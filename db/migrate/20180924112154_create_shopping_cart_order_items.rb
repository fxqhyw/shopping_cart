class CreateShoppingCartOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_order_items do |t|
      t.integer :quantity, default: 1
      t.integer :product_id, index: true
      t.integer :order_id, index: true

      t.timestamps
    end
  end
end
