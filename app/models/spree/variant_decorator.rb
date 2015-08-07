module Spree
  Variant.class_eval do
    include ProductCustomizationsBuilder

    # This method is only overridden to pass in original options hash.
    # It's to allow the hook method to modify that options hash that will then
    # be added to the LineItem attributes.
    # We need it because the form options are just plain text that need
    # wrapping in a complex ascociciation object before persisting.
    # This feels like a hack but I can't think of a better way yet.
    # I've opened issue #6610 with Spree to find an alternative.
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
          send(m, currency, options) # change to pass in all options
        else
          0
        end
      }.sum
    end

    def product_customizations_price_modifier_amount_in(_currency, options)
      # we need to build (but not save) a line item so we can
      # reuse some code.  A small price to pay IMO
      li = LineItem.new
      li.variant = self # So calculators can access the base price
      li.build_product_customizations options["product_customizations"]
      options["product_customizations"] = li.product_customizations
      li.product_customizations.map(&:price).sum
    end
  end
end
