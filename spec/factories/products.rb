FactoryBot.define do
  factory :product, class: 'Book' do
    title { FFaker::Lorem.phrase }
    description { FFaker::Lorem.phrase }
    price { rand(21.99..42.99) }
  end
end
