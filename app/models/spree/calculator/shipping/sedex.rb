module Spree
  module Calculator::Shipping
    class Sedex < CorreiosBaseCalculator
      def self.description
        "SEDEX"
      end

      def shipping_method
        if has_contract?
          :sedex_com_contrato_6
        else
          :sedex
        end
      end

      def shipping_code
        if has_contract?
          '04162'
        else
          '40010'
        end
      end
    end
  end
end
