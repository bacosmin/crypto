module Services
  module Calculators
    class Base
      attr_reader :currency, :exchange_rates_service

      def initialize(currency, exchange_rates_service)
        @currency = currency
        @exchange_rates_service = exchange_rates_service
      end

      def multisig_price
        return unless currency.multiplication_factor

        (BigDecimal(price, 25) *  BigDecimal(currency.multiplication_factor, 25)).to_s
      end

      private

      def grabber
        @grabber ||= Services::DataGrabbers::Factory.grabber(currency.currency_id, exchange_rates_service)
      end

      def price_per_byte
        BigDecimal(grabber.price, 25)
      end

      def exchange_rate
        BigDecimal(grabber.usd_price, 25)
      end
    end
  end
end