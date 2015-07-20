[
  { a: 1, b: 11, c: 11 },
  { a: 1, b: 12, c: 12 },
  { a: 2, b: 21, c: 21 },
  { a: 3, b: 31, c: 31 }
]

{
  1 => { 12 => 13,  },
  2 => { 22 => 23 },
  3 => { 32 => 33 }
}

module Spree
  module ProductCustomizationsBuilder
    def build_product_customizations(options)
      return unless options

      p options

      customizations = {}
      options.each do |cust_opt_val|
        customization = customizations[cust_opt_val[:customization_id]] ||= {}
        customization[cust_opt_val[:option_id]] = cust_opt_val[:option_value]
      end
      p customizations

      customizations.each do |ct_id, cv_pair|
        # [customization_type_id =>
        #   { customized_product_option_id => <user input>, ... }]
        next if cv_pair.empty? || cv_pair.values.all?(&:empty?)

        # create a product_customization based on ct_id
        pc = product_customizations.build(product_customization_type_id: ct_id)

        cv_pair.each_pair do |cust_opt_id, user_input|
          # create a customized_product_option based on cust_opt_id
          # and attach to its customization
          cpo = pc.customized_product_options.build(
            customizable_product_option_id: cust_opt_id
          )

          if user_input.is_a? String
            cpo.value = user_input
          else
            cpo.value = ""
            cpo.customization_image = user_input["customization_image"]
          end
        end
      end
    end
  end
end
