# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_10_10_093556) do
  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "addresses", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "country"
    t.string "line1"
    t.string "line2"
    t.integer "postal_code"
    t.string "city"
    t.string "state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_addresses_on_user_id"
  end

  create_table "deals", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "price_in_cents"
    t.integer "discount_price_in_cents"
    t.integer "quantity"
    t.boolean "is_publishable", default: false
    t.decimal "tax_percentage"
    t.integer "created_by"
    t.date "published_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "unpublished"
  end

  create_table "line_items", force: :cascade do |t|
    t.integer "deal_id", null: false
    t.integer "order_id", null: false
    t.integer "quantity"
    t.integer "discounted_price"
    t.decimal "loyality_discounted_price", precision: 10, scale: 2, default: "0.0"
    t.integer "loyality_discount_percentage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_line_items_on_deal_id"
    t.index ["order_id"], name: "index_line_items_on_order_id"
  end

  create_table "order_transactions", force: :cascade do |t|
    t.integer "order_id", null: false
    t.string "transaction_id"
    t.string "status"
    t.integer "shipping_address_id", null: false
    t.string "code"
    t.string "reason"
    t.string "payment_mode"
    t.datetime "created_at", precision: nil, null: false
    t.string "payment_intent_id"
    t.decimal "amount", precision: 10, scale: 2
    t.index ["order_id"], name: "index_order_transactions_on_order_id"
    t.index ["shipping_address_id"], name: "index_order_transactions_on_shipping_address_id"
  end

  create_table "orders", force: :cascade do |t|
    t.integer "status"
    t.datetime "placed_at"
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "price", default: 0
    t.decimal "discount_price", precision: 10, scale: 2, default: "0.0"
    t.integer "shipping_address_id"
    t.index ["shipping_address_id"], name: "index_orders_on_shipping_address_id"
    t.index ["user_id"], name: "index_orders_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.string "role", default: "user"
    t.datetime "verified_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "verification_token"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "addresses", "users"
  add_foreign_key "deals", "users", column: "created_by"
  add_foreign_key "line_items", "deals"
  add_foreign_key "line_items", "orders"
  add_foreign_key "order_transactions", "addresses", column: "shipping_address_id"
  add_foreign_key "order_transactions", "orders"
  add_foreign_key "orders", "users"
end
