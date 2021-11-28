# frozen_string_literal: true

module Services
  module DataGrabbers
    module Satoshy
      class Bitcoin < Services::DataGrabbers::Base
        def price
          parsed_response['priority']
        end

        def usd_price
          exchange_rates_service.usd_price('bitcoin')
        end

        private

        def url
          ENV['SATOSHY_BITCOIN_URL']
        end
      end
    end
  end
end
