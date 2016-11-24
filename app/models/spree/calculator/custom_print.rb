module Spree
  class Calculator::CustomPrint < Calculator

    preference :min_amount, :integer, default: 0
    preference :max_amount, :integer, default: 100000

    #attr_accessible :preferred_multiplier, :preferred_min_amount, :preferred_max_amount

    def self.description
      "Custom Print Calculator"
    end

    def self.register
      super
      ProductCustomizationType.register_calculator(self)
    end

    def create_options
      # This calculator knows that it needs one CustomizableOption named amount
      [
        CustomizableProductOption.create(name: "yards", presentation: "Yards"),
        CustomizableProductOption.create(name: "customization_image", presentation: "Customization Image"),
        CustomizableProductOption.create(name: "print_type", presentation: "Print Type")
      ]
    end

    def compute(product_customization, variant = nil)
      return 0 unless valid_configuration? product_customization

      yards = product_customization.customized_product_options.detect do |cpo|
        cpo.customizable_product_option.name == "yards"
      end rescue 0

      print_type = product_customization.customized_product_options.detect do |cpo|
        cpo.customizable_product_option.name == "print_type"
      end rescue nil

      # calculate price for strike or other print
      ((print_type.value.to_s == 'strike') ? 0 : (yards.value.to_i * variant.price)) - variant.price
    end

    def valid_configuration?(_product_customization)
      true
    end
  end
end
