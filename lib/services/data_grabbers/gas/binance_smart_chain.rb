module Services
  module DataGrabbers
    module Gas
      class BinanceSmartChain < Services::DataGrabbers::Gas::Base

        def usd_price
          result['UsdPrice']
        end

        private

        def url
          ENV["GAS_BINANCE_SMART_CHAIN_URL"]
        end
      end
    end
  end
end