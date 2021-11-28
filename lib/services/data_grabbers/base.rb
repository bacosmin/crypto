# frozen_string_literal: true

module Services
  module DataGrabbers
    class Base
      attr_reader :parsed_response, :exchange_rates_service

      def initialize(exchange_rates_service)
        @exchange_rates_service = exchange_rates_service
        load_data
      end

      def usd_price
        raise NotImplementedError
      end

      def price
        raise NotImplementedError
      end

      private

      def load_data(custom_url: nil)
        response = Faraday.get(custom_url || url)

        parse_body(response.body)
      rescue Faraday::ConnectionFailed => e
        Rails.logger.error(e)
        raise e
      end

      def url
        raise NotImplementedError
      end

      def parse_body(body)
        @parsed_response = JSON.parse(body)
      rescue JSON::ParserError => e
        Rails.logger.error(e)
        raise "Response parse error: #{e.message}"
      end
    end
  end
end
