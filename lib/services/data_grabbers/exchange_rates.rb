# frozen_string_literal: true

module Services
  module DataGrabbers
    class ExchangeRates < Services::DataGrabbers::Base
      def initialize
        load_data
      end

      def usd_price(currecny_id)
        selected = select(currecny_id)

        (selected || {})['priceUsd']
      end

      private

      def url
        ENV['EXCHANGE_RATES_URL']
      end

      def select(currecny_id)
        parsed_response['data'].find { |e| e['id'] == currecny_id }
      end
    end
  end
end
