class Book < ApplicationRecord
  has_many :order_items, class_name: 'ShoppingCart::OrderItem', dependent: :destroy
end
