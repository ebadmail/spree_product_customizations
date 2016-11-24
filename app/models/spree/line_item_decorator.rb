module Spree
  LineItem.class_eval do
    has_many :product_customizations, dependent: :destroy

    include ProductCustomizationsBuilder

    def customization_option_value(type_name, option_name)

      customization = product_customizations.with_type_name(type_name).first
      return nil if customization.nil?
      option = customization.customized_product_options.with_name(option_name).first
      return nil if option.nil?
      option.value

    end
  end
end
