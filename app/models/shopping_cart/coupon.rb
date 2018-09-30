module ShoppingCart
  class Coupon < ApplicationRecord
    has_many :orders, dependent: :nullify

    validates_uniqueness_of :code
    validates_presence_of :discount
  end
end
