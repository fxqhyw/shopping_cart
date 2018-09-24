FactoryBot.define do
  factory :order_item, class: 'ShoppingCart::OrderItem' do
    product
    quantity { 1 }
    order
  end
end
