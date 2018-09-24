module ShoppingCart
  class CreditCard < ApplicationRecord
    belongs_to :order

    validates :name, :number, :expiration_date, presence: true
    validates :name, length: { maximum: 30 }, format: { with: /\A[A-z\s]+\z/,
                                                        message: "must consist of only letters" }
    validates :number, length: { is: 4 }, format: { with: /\A[0-9]+\z/,
                                                                       message: "must consist of only 4 digits" }
    validates :expiration_date, length: { is: 5 }, format: { with: /\A(0{1}([0-9]){1}|1{1}([0-2]){1})\/\d{2}\z/,
                                                             message: "format must be MM/YY" }
  end
end
