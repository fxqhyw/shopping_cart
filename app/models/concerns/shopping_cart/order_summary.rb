module ShoppingCart
  module OrderSummary
    extend ActiveSupport::Concern

    def subtotal
      order_items.sum(&:total_price)
    end

    def discount
      coupon.try(:discount) || 0.00
    end

    def delivery_price
      delivery.try(:price) || 0.00
    end

    def order_total
      subtotal - discount + delivery_price
    end

    def items_count
      order_items.collect(&:quantity).compact.sum
    end
  end
end
