# frozen_string_literal: true

module Services
  module DataGrabbers
    module Gas
      class Ethereum < Services::DataGrabbers::Gas::Base
        def usd_price
          exchange_rates_service.usd_price('ethereum')
        end

        private

        def url
          ENV['GAS_ETHEREUM_URL']
        end
      end
    end
  end
end
