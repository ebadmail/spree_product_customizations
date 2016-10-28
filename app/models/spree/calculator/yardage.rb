module Spree
  class Calculator::Yardage < Calculator

    preference :min_amount, :integer, default: 0
    preference :max_amount, :integer, default: 100000

    #attr_accessible :preferred_multiplier, :preferred_min_amount, :preferred_max_amount

    def self.description
      "Yardage Calculator"
    end

    def self.register
      super
      ProductCustomizationType.register_calculator(self)
    end

    def create_options
      # This calculator knows that it needs one CustomizableOption named amount
      [
        CustomizableProductOption.create(name: "yards", presentation: "Yards")
      ]
    end

    def compute(product_customization, variant = nil)
      return 0 unless valid_configuration? product_customization
      # expecting only one CustomizedProductOption
      opt = product_customization.customized_product_options.detect do |cpo|
        cpo.customizable_product_option.name == "yards"
      end rescue 0.0
      opt.value.to_i * variant.price
    end

    def valid_configuration?(_product_customization)
      true
    end
  end
end
