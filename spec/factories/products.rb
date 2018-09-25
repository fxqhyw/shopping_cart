FactoryBot.define do
  factory :product do
    title { FFaker::Lorem.phrase }
    price { rand(21.99..42.99) }
  end
end
