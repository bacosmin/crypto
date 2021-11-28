# frozen_string_literal: true

module Services
  module DataGrabbers
    class Factory
      MAPPING = {
        bitcoin: Services::DataGrabbers::Satoshy::Bitcoin,
        bitcoin_sv: Services::DataGrabbers::Satoshy::BitcoinSv,
        binance_smart_chain: Services::DataGrabbers::Gas::BinanceSmartChain,
        ethereum: Services::DataGrabbers::Gas::Ethereum
      }.freeze

      def self.grabber(currency_id, exchange_rates_service)
        cls = MAPPING[currency_id.to_s.underscore.downcase.to_sym]

        if cls
          cls.new(exchange_rates_service)
        else
          OpenStruct.new(get_price: nil)
        end
      end
    end
  end
end
