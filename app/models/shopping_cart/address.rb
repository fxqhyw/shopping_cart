module ShoppingCart
  class Address < ApplicationRecord
    belongs_to :order, optional: true
    belongs_to :user, optional: true
  
    validates :first_name, :last_name, :address, :city,
              :zip, :country, :phone, presence: true
    validates :first_name, :last_name, :address, :city, :country, length: { maximum: 50 }
    validates :first_name, :last_name, :city,
              format: { with: /\A[A-z\s]+\z/, message: 'must consist of only letters' }
    validates :address, format: { with: /\A[A-z0-9\s.,-]+\z/,
                                  message: 'must consist of letters, digits and ’,’, ‘-’, ‘ ’ only, no special symbols' }
    validates :zip, length: { maximum: 10 }, format: { with: /\A[0-9]+\z/, message: 'must consist of only digits' }
    validates :phone, length: { maximum: 20 }, format: { with: /\A^\+[0-9]+\z/,
                                                         message: "must starts with '+' and consist of only digits" }
  end
end
