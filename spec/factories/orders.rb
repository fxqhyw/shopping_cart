FactoryBot.define do
  factory :order, class: 'ShoppingCart::Order' do
    total_price { nil }
    status { 'in_progress' }
    user

    factory :order_with_delivery do
      delivery
    end

    trait :in_queue do
      total_price { rand(50.00..250.00) }
      status { 'in_queue' }
      number { 'R1111111' }
    end

    trait :in_delivery do
      total_price { rand(50.00..250.00) }
      status { 'in_delivery' }
      number { 'R2222222' }
    end

    trait :delivered do
      total_price { rand(50.00..250.00) }
      status { 'delivered' }
      number { 'R3333333' }
    end
  end
end
