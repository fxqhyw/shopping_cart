class CreateShoppingCartOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_orders do |t|
      t.decimal :total_price
      t.string :status
      t.string :number
      t.integer :user_id, index: true
      t.integer :delivery_id, index: true
      t.integer :coupon_id, index: true

      t.timestamps
    end
  end
end
