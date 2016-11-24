module Spree
  class ProductCustomization < ActiveRecord::Base
    belongs_to :product_customization_type
    belongs_to :line_item
    has_many :customized_product_options, dependent: :destroy

    scope :with_type_name, -> (name) { joins(:product_customization_type).where('spree_product_customization_types.name = ?', name)}

    # price might depend on something contained in the variant
    # (like product property value), so optionally pass that in
    def price(variant = nil)
      product_customization_type.calculator.compute(self, variant)
    end

    def calculator
      product_customization_type.calculator
    end
  end
end
