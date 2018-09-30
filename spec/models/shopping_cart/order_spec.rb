require 'rails_helper'

module ShoppingCart
  RSpec.describe Order, type: :model do
    context 'associations' do
      %i[coupon delivery user].each do |field|
        it { is_expected.to belong_to(field) }
      end
      %i[shipping_address billing_address credit_card].each do |field|
        it { is_expected.to have_one(field).dependent(:destroy) }
      end
      it { is_expected.to have_many(:order_items).dependent(:destroy) }
    end

    context 'validations' do
      it { is_expected.to validate_presence_of(:status) }
    end
  end
end
