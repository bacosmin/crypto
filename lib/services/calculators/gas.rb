# frozen_string_literal: true

module Services
  module Calculators
    class Gas < Services::Calculators::Base
      def price
        @price ||= (price_per_byte * amount * exchange_rate * BigDecimal(10**-9, 25)).to_s
      end

      private

      def amount
        BigDecimal('21000', 25)
      end
    end
  end
end
