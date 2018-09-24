module ShoppingCart
  module TotalPrice
    extend ActiveSupport::Concern

    def total_price
      product.price * quantity
    end
  end
end
