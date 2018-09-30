class CreateBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :books do |t|
      t.string :title
      t.string :description
      t.decimal :price, precision: 8, scale: 2
    end
  end
end
