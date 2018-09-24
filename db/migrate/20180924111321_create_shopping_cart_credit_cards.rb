class CreateShoppingCartCreditCards < ActiveRecord::Migration[5.1]
  def change
    create_table :shopping_cart_credit_cards do |t|
      t.string :name
      t.string :number
      t.string :expiration_date
      t.integer :order_id, index: true

      t.timestamps
    end
  end
end
