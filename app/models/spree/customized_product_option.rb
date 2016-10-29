module Spree
  # in populate, params[:customization] contains all the fields supplied by
  # the customization_type_view. Those values are saved in this class
  class CustomizedProductOption < ActiveRecord::Base
    belongs_to :product_customization
    belongs_to :customizable_product_option

    belongs_to :customization_image, :class_name => 'Image'

    def empty?
      value.empty? && !customization_image.nil?
    end
  end
end
