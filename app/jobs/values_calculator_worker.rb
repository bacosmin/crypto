# frozen_string_literal: true

require 'retriable'

class ValuesCalculatorWorker
  include Sidekiq::Worker
  sidekiq_options retry: 10

  def perform
    exchange_rates_service = Services::DataGrabbers::ExchangeRates.new
    Currency.all.each do |currency|
      Rails.logger.info "processing #{currency.name}"

      calculator = Retriable.retriable(tries: 3, base_interval: 1) do
        Services::Calculators::Factory.calculator(currency, exchange_rates_service)
      end

      process_price(currency, calculator)
      process_multisig(currency, calculator)
      currency.save!

      Rails.logger.info "processing #{currency.name} ->  #{currency.name} done"

      sleep(2)
    end
  end

  private

  def process_multisig(currency, calculator)
    Retriable.retriable(tries: 3, base_interval: 1) do |count|
      Rails.logger.info "processing #{currency.name} ->  multisig_price(try#{count})"
      currency.multisig_transaction_cost = calculator.multisig_price
    end
  end

  def process_price(currency, calculator)
    Retriable.retriable(tries: 3, base_interval: 1) do |count|
      Rails.logger.info "processing #{currency.name} -> price(try#{count})"
      currency.transaction_cost = calculator.price
    end
  end
end
