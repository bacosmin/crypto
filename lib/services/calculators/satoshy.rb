module Services
  module Calculators
    class Satoshy < Services::Calculators::Base

      def price
        @price ||= (price_per_byte * amount_of_bytes * exchange_rate * BigDecimal(10 ** -8, 25)).to_s
      end

      private

      def amount_of_bytes
        BigDecimal('192', 25)
      end
    end
  end
end
