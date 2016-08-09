# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160809170320) do

  create_table "batches", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "brands_users", id: false, force: :cascade do |t|
    t.integer "brand_id"
    t.integer "user_id"
  end

  add_index "brands_users", ["brand_id"], name: "index_brands_users_on_brand_id"
  add_index "brands_users", ["user_id"], name: "index_brands_users_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price"
    t.boolean  "out_of_stock", default: false
    t.integer  "product_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "categories", ["product_id"], name: "index_categories_on_product_id"

  create_table "colors", force: :cascade do |t|
    t.string   "real_color"
    t.string   "hue"
    t.string   "tone"
    t.string   "darkness"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "fabrics", force: :cascade do |t|
    t.string   "material"
    t.string   "color"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.boolean  "out_of_stock", default: false
    t.integer  "brand_id"
  end

  add_index "fabrics", ["brand_id"], name: "index_fabrics_on_brand_id"

  create_table "patterns", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
    t.integer  "brand_id"
  end

  add_index "patterns", ["brand_id"], name: "index_patterns_on_brand_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "brand_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "products", ["brand_id"], name: "index_products_on_brand_id"

  create_table "remissions", force: :cascade do |t|
    t.integer  "store_id"
    t.boolean  "active",         default: true
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "price_modifier", default: 0
  end

  add_index "remissions", ["store_id"], name: "index_remissions_on_store_id"

  create_table "stores", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.string   "rfc"
    t.string   "phone"
    t.string   "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "units", force: :cascade do |t|
    t.string   "product_code"
    t.boolean  "sold",         default: false
    t.integer  "category_id"
    t.integer  "store_id"
    t.integer  "remission_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "fabric_id"
    t.integer  "color_id"
    t.integer  "pattern_id"
    t.integer  "batch_id"
  end

  add_index "units", ["batch_id"], name: "index_units_on_batch_id"
  add_index "units", ["category_id"], name: "index_units_on_category_id"
  add_index "units", ["color_id"], name: "index_units_on_color_id"
  add_index "units", ["fabric_id"], name: "index_units_on_fabric_id"
  add_index "units", ["pattern_id"], name: "index_units_on_pattern_id"
  add_index "units", ["remission_id"], name: "index_units_on_remission_id"
  add_index "units", ["store_id"], name: "index_units_on_store_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",             default: false
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end
