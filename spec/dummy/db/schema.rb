# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20180924160548) do

  create_table "products", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.decimal "price", precision: 8, scale: 2
  end

  create_table "shopping_cart_addresses", force: :cascade do |t|
    t.string "type"
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.string "city"
    t.string "zip"
    t.string "country"
    t.string "phone"
    t.integer "user_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shopping_cart_addresses_on_order_id"
    t.index ["user_id"], name: "index_shopping_cart_addresses_on_user_id"
  end

  create_table "shopping_cart_billing_addresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_coupons", force: :cascade do |t|
    t.string "code"
    t.decimal "discount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_credit_cards", force: :cascade do |t|
    t.string "name"
    t.string "number"
    t.string "expiration_date"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shopping_cart_credit_cards_on_order_id"
  end

  create_table "shopping_cart_deliveries", force: :cascade do |t|
    t.string "name"
    t.decimal "price"
    t.string "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_order_items", force: :cascade do |t|
    t.integer "quantity", default: 1
    t.integer "product_id"
    t.integer "order_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_shopping_cart_order_items_on_order_id"
    t.index ["product_id"], name: "index_shopping_cart_order_items_on_product_id"
  end

  create_table "shopping_cart_orders", force: :cascade do |t|
    t.decimal "total_price"
    t.string "status"
    t.string "number"
    t.integer "user_id"
    t.integer "delivery_id"
    t.integer "coupon_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["coupon_id"], name: "index_shopping_cart_orders_on_coupon_id"
    t.index ["delivery_id"], name: "index_shopping_cart_orders_on_delivery_id"
    t.index ["user_id"], name: "index_shopping_cart_orders_on_user_id"
  end

  create_table "shopping_cart_shipping_addresses", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
  end

end
