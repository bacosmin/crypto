require 'retriable'

class ValuesCalculatorWorker
  include Sidekiq::Worker
  sidekiq_options :retry => 10

  def perform
    exchange_rates_service = Services::DataGrabbers::ExchangeRates.new

    Currency.all.each do |c|
      Rails.logger.info "processing #{c.name}"

      calculator = Retriable.retriable(tries: 3, base_interval: 1) do
        Services::Calculators::Factory.calculator(c, exchange_rates_service)
      end

      Retriable.retriable(tries: 3, base_interval: 1) do |count|
        Rails.logger.info "processing #{c.name} -> price(try#{count})"
        c.transaction_cost = calculator.price
      end

      Retriable.retriable(tries: 3, base_interval: 1) do |count|
        Rails.logger.info "processing #{c.name} ->  multisig_price(try#{count})"
        c.multisig_transaction_cost = calculator.multisig_price
      end
      c.save!
      Rails.logger.info "processing #{c.name} ->  #{c.name} done"
      sleep(2)
    end
  end
end
