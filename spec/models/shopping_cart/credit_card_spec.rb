require 'rails_helper'

module ShoppingCart
  RSpec.describe CreditCard, type: :model do
    context 'associations' do
      it { is_expected.to belong_to(:order) }
    end

    context 'validations' do
      %i[name number expiration_date].each do |field|
        it { is_expected.to validate_presence_of(field) }
      end

      it { is_expected.to validate_length_of(:name).is_at_most(30) }
      it { is_expected.to validate_length_of(:number).is_equal_to(4) }
      it { is_expected.to validate_length_of(:expiration_date).is_equal_to(5) }
    end
  end
end
