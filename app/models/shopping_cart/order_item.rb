module ShoppingCart
  class OrderItem < ApplicationRecord
    include ShoppingCart::TotalPrice

    belongs_to :product, class_name: ShoppingCart.product_class.to_s
    belongs_to :order

    validates :quantity, numericality: { greater_than: 0 }

    scope :created, -> { order(created_at: :desc) }
  end
end
