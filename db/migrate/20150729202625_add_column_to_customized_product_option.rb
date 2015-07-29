class AddColumnToCustomizedProductOption < ActiveRecord::Migration
  def change
    add_column :spree_customized_product_options, :customization_image, :string
  end
end
