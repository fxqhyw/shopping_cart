module ShoppingCart
  module ApplicationHelper
    include ShoppingCart::CurrentSession

    def order_items_quantity
      current_order&.items_count || 0
    end
  end
end
