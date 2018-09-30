require 'rails_helper'

module ShoppingCart
  RSpec.describe Delivery, type: :model do
    context 'associations' do
      it { is_expected.to have_many(:orders) }
    end

    context 'validations' do
      %i[name price duration].each do |field|
        it { is_expected.to validate_presence_of(field) }
      end
      it { is_expected.to validate_uniqueness_of(:name) }
      it { is_expected.to validate_numericality_of(:price).is_greater_than_or_equal_to(0.01) }
    end
  end
end
