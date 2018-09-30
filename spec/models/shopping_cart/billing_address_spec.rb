require 'rails_helper'

module ShoppingCart
  RSpec.describe BillingAddress, type: :model do
    it { expect(described_class).to be < Address }
  end
end
