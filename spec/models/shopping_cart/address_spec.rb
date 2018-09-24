require 'rails_helper'

module ShoppingCart
  RSpec.describe Address, type: :model do
    context 'associations' do
      it { is_expected.to belong_to(:order) }
    end

    context 'validations' do
      %i[first_name last_name address city zip country phone].each do |field|
        it { is_expected.to validate_presence_of(field) }
      end

      %i[first_name last_name address city].each do |field|
        it { is_expected.to validate_length_of(field).is_at_most(50) }
      end
    end
  end
end
