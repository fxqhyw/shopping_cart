FactoryBot.define do
  factory :address, class: 'ShoppingCart::Address' do
    first_name { FFaker::Lorem.word }
    last_name { FFaker::Lorem.word }
    address { FFaker::Lorem.word }
    city { FFaker::Lorem.word }
    zip { '7777' }
    country { FFaker::Address.country }
    phone { '+1234567890' }
    type { 'ShoppingCart::BillingAddress' }
    order { nil }
    user
  end
end
