# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Currency.create!(name: 'Bitcoin', symbol: 'BTC', multiplication_factor: '2.0', currency_id: 'bitcoin')
Currency.create!(name: 'Ethereum', symbol: 'ETH', multiplication_factor: '20.0', currency_id: 'ethereum')
Currency.create!(name: 'Binance Smart Chain', symbol: 'BSC', multiplication_factor: '20.0', currency_id: 'binance_smart_chain')
Currency.create!(name: 'Bitcoin SV', symbol: 'BSV', currency_id: 'bitcoin-sv')

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