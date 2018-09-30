module ShoppingCart
  class Delivery < ApplicationRecord
    has_many :orders, dependent: :nullify

    validates :name, :price, :duration, presence: true
    validates :name, uniqueness: true
    validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  end
end
