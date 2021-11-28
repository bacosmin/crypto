# frozen_string_literal: true

module Services
  module DataGrabbers
    module Satoshy
      class BitcoinSv < Base
        attr_reader :standard

        # Assumption: relay and mining fee are both required in order to have a full transaction
        def price
          (mining_fee + relay_fee).to_s
        end

        def usd_price
          exchange_rates_service.usd_price('bitcoin-sv')
        end

        private

        def mining_fee
          BigDecimal(standard.dig('miningFee', 'satoshis'), 25) /
            BigDecimal(standard.dig('miningFee', 'bytes'), 25)
        end

        def relay_fee
          BigDecimal(standard.dig('relayFee', 'satoshis'), 25) /
            BigDecimal(standard.dig('relayFee', 'bytes'), 25)
        end

        def parse_body(body)
          super(body)
          parsed_payload = JSON.parse(parsed_response['payload'])

          @standard = parsed_payload['fees'].find { |e| e['feeType'] == 'standard' }
        end

        def url
          ENV['SATOSHY_BITCOIN_SV_URL']
        end
      end
    end
  end
end
