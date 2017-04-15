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

ActiveRecord::Schema.define(version: 20170406062020) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "engine_cart_addresses", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "address"
    t.string   "city"
    t.string   "zip"
    t.integer  "country_id"
    t.string   "phone"
    t.string   "address_type"
    t.string   "addressable_type"
    t.integer  "addressable_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["addressable_type", "addressable_id"], name: "addressable_index", using: :btree
    t.index ["country_id"], name: "index_engine_cart_addresses_on_country_id", using: :btree
  end

  create_table "engine_cart_countries", force: :cascade do |t|
    t.string   "name"
    t.string   "phone_number"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "engine_cart_order_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "order_id"
    t.float    "unit_price"
    t.integer  "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["order_id"], name: "index_engine_cart_order_items_on_order_id", using: :btree
  end

  create_table "engine_cart_orders", force: :cascade do |t|
    t.integer  "user_id"
    t.float    "total_price"
    t.string   "state",        default: "cart"
    t.string   "prev_state"
    t.string   "order_number"
    t.date     "placed_date"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["user_id"], name: "index_engine_cart_orders_on_user_id", using: :btree
  end

  create_table "engine_cart_payments", force: :cascade do |t|
    t.string   "card_number"
    t.string   "name_on_card"
    t.string   "mm_yy"
    t.integer  "cvv"
    t.integer  "order_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["order_id"], name: "index_engine_cart_payments_on_order_id", using: :btree
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.string   "description"
    t.float    "price"
    t.string   "product_type"
    t.string   "status"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
