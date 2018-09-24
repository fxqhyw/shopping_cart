class CreateShoppingCartDeliveries < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_deliveries do |t|
      t.string :name
      t.decimal :price
      t.string :duration

      t.timestamps
    end
  end
end
