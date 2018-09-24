class CreateShoppingCartAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_addresses do |t|
      t.string :type
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :city
      t.string :zip
      t.string :country
      t.string :phone
      t.integer :user_id, index: true
      t.integer :order_id, index: true

      t.timestamps
    end
  end
end
