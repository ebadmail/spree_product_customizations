module Spree
  Variant.class_eval do
    include ProductCustomizationsBuilder

    # This method is only overridden for the very important hack.
    # Without deleting the key from options Active Record tries to add the key
    # as a field in the LineItem, which isn't what we want so it crashes.
    # I've opened an issue with Spree to find an alternative.
    # For now I have added a safety pig to watch over it.
    #                          _
    #  _._ _..._ .-',     _.._(`))
    # '-. `     '  /-._.-'    ',/
    #    )         \            '.
    #   / _    _    |             \
    #  |  a    a    /              |
    #  \   .-.                     ;
    #   '-('' ).-'       ,'       ;
    #      '-;           |      .'
    #         \           \    /
    #         | 7  .__  _.-\   \
    #         | |  |  ``/  /`  /
    #        /,_|  |   /,_/   /
    #           /,_/      '`-'
    def price_modifier_amount_in(currency, options = {})
      return 0 unless options.present?

      options.keys.map { |key|
        m = "#{key}_price_modifier_amount_in".to_sym
        if self.respond_to? m
          v = self.send(m, currency, options[key])
          options.delete(key) # Very important hack!
          v
        else
          0
        end
      }.sum
    end

    def product_customizations_price_modifier_amount_in(currency, options)
      # we need to build (but not save) a line item so we can
      # reuse some code.  A small price to pay IMO
      li = LineItem.new
      li.build_product_customizations(options)
      li.product_customizations.map(&:price).sum
    end
  end
end
