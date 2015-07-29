Deface::Override.new(:virtual_path => "spree/products/_cart_form",
                         :name => "add_multipart_to_cart_form",
                         :replace => "erb[loud]:contains('form_for :order')",
                         :text => "<%= form_for :order, :html => { :multipart => true }, :url => populate_orders_path do |f| %>")
