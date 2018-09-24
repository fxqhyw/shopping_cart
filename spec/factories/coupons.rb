FactoryBot.define do
  factory :coupon, class: 'ShoppingCart::Coupon' do
    code { FFaker::Lorem.word }
    discount { 9.99 }
  end
end
