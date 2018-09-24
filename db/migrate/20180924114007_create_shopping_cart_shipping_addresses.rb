class CreateShoppingCartShippingAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_shipping_addresses do |t|

      t.timestamps
    end
  end
end
