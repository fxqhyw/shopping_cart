class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :validatable

  has_one :billing_address, class_name: 'ShoppingCart::BillingAddress', foreign_key: :user_id
  has_one :shipping_address, class_name: 'ShoppingCart::ShippingAddress', foreign_key: :user_id
  has_many :orders, class_name: 'ShoppingCart::Order', foreign_key: :user_id
end
