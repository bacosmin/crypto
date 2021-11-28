# frozen_string_literal: true

module Services
  module Calculators
    class Factory
      MAPPING = {
        bitcoin: Services::Calculators::Satoshy,
        bitcoin_sv: Services::Calculators::Satoshy,
        binance_smart_chain: Services::Calculators::Gas,
        ethereum: Services::Calculators::Gas
      }.freeze

      def self.calculator(currency, exchange_rates_service)
        cls = MAPPING[currency.currency_id.to_s.underscore.downcase.to_sym]

        if cls
          cls.new(currency, exchange_rates_service)
        else
          Services::Calculators::DummyCalculator.new
        end
      end
    end
  end
end
