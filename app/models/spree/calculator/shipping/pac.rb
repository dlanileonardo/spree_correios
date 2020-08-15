module Spree
  module Calculator::Shipping
    class Pac < CorreiosBaseCalculator
      def self.description
        "PAC"
      end

      def shipping_method
        if has_contract?
          :pac_com_contrato_2
        else
          :pac
        end
      end

      def shipping_code
        if has_contract?
          '04669'
        else
          '41106'
        end
      end
    end
  end
end
