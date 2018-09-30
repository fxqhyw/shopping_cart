FactoryBot.define do
  factory :credit_card, class: 'ShoppingCart::CreditCard' do
    name { FFaker::Education.major }
    number { Array.new(4) { rand(1..9) }.join }
    expiration_date { '11/22' }
    order { nil }
  end
end
