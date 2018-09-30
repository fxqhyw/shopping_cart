module ShoppingCart
  class Order < ApplicationRecord
    include ShoppingCart::OrderSummary
    include AASM

    belongs_to :user, class_name: ShoppingCart.user_class.to_s, optional: true
    belongs_to :coupon, optional: true
    belongs_to :delivery, optional: true
    has_many :order_items, dependent: :destroy
    has_one :shipping_address, dependent: :destroy
    has_one :billing_address, dependent: :destroy
    has_one :credit_card, dependent: :destroy

    validates :status, presence: true

    scope :in_progress, -> { where(status: :in_progress).order(created_at: :desc) }
    scope :in_queue, -> { where(status: :in_queue).order(created_at: :desc) }
    scope :in_delivery, -> { where(status: :in_delivery).order(created_at: :desc) }
    scope :delivered, -> { where(status: :delivered).order(created_at: :desc) }
    scope :canceled, -> { where(status: :canceled).order(created_at: :desc) }
    scope :placed, -> { where.not(status: :in_progress).order(created_at: :desc) }

    aasm column: 'status', whiny_transitions: false do
      state :in_progress, initial: true
      state :in_queue, :in_delivery, :delivered, :canceled

      event :confirm do
        transitions from: :in_progress, to: :in_queue
      end
    end
  end
end
