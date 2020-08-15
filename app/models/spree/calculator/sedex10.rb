module Spree
  class Calculator::Sedex10 < CorreiosBaseCalculator
    def self.description
      "SEDEX 10"
    end

    def shipping_method
      :sedex_10
    end

    def shipping_code
      40215
    end
  end
end
