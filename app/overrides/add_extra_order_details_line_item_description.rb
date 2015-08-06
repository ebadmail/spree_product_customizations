# There are so many places Spree duplicated showing a list of line items!

Deface::Override.new(virtual_path: "spree/shared/_order_details",
                     name: "add_extra_order_details_line_item_description",
                     insert_bottom: "[data-hook='order_item_description']",
                     partial: "spree/shared/extra_order_details_line_item_description")

Deface::Override.new(virtual_path: "spree/shared/_line_item",
                     name: "add_extra_order_details_line_item_description_2",
                     insert_bottom: '[data-hook="line_item_description"]',
                     partial: "spree/shared/extra_order_details_line_item_description")

Deface::Override.new(virtual_path: "spree/admin/orders/_line_item",
                     name: "add_extra_order_details_line_item_description_admin_2",
                     insert_bottom: "data-hook='admin_order_form_line_item_row'",
                     partial: "spree/shared/extra_order_details_line_item_description")

Deface::Override.new(virtual_path: "spree/admin/orders/_line_items",
                     name: "add_extra_order_details_line_item_description_admin_3",
                     insert_bottom: '.line-item-name',
                     partial: "spree/shared/extra_order_details_line_item_description")

Deface::Override.new(virtual_path: "spree/admin/orders/_shipment_manifest",
                     name: "add_extra_order_details_line_item_description_admin_4",
                     insert_bottom: '.item-name',
                     partial: "spree/shared/extra_order_details_line_item_description")

Deface::Override.new(virtual_path: "spree/checkout/_delivery",
                     name: "add_extra_order_details_line_item_description_admin_5",
                     insert_bottom: '.item-name',
                     partial: "spree/shared/extra_order_details_line_item_description")
