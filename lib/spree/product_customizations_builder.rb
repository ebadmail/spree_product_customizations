module Spree
  module ProductCustomizationsBuilder
    
    def build_product_customizations(options)
      
      return unless options

      customizations = {}
      
      options.each do |cust_opt_val|
        customization = customizations[cust_opt_val[:customization_id]] ||= {}
        
        # Allowing attribut option_value: :cusomization_image overrides option_value as a string so we assign it here. 
        if cust_opt_val.has_key? :customization_image
          customization[cust_opt_val[:option_id]] = {customization_image: cust_opt_val[:customization_image]}
        else        
          customization[cust_opt_val[:option_id]] = cust_opt_val[:option_value]
        end
        
      end
      
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
            cpo.customization_image = user_input[:customization_image]
          end
        end     
      end  
          
    end 
      
  end 
end
