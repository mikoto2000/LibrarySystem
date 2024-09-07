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

ActiveRecord::Schema[7.2].define(version: 2024_09_07_081710) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_author_relationships", force: :cascade do |t|
    t.bigint "book_master_id", null: false
    t.bigint "author_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_id"], name: "index_book_author_relationships_on_author_id"
    t.index ["book_master_id"], name: "index_book_author_relationships_on_book_master_id"
  end

  create_table "book_masters", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.date "publication_date"
    t.bigint "ndc_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ndc_category_id"], name: "index_book_masters_on_ndc_category_id"
  end

  create_table "book_stock_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_stocks", force: :cascade do |t|
    t.bigint "book_master_id", null: false
    t.bigint "book_stock_status_id", null: false
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_master_id"], name: "index_book_stocks_on_book_master_id"
    t.index ["book_stock_status_id"], name: "index_book_stocks_on_book_stock_status_id"
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "email_address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lending_sets", force: :cascade do |t|
    t.bigint "customer_id", null: false
    t.bigint "lending_status_id", null: false
    t.date "lend_start_date"
    t.date "return_deadline_date"
    t.date "return_date"
    t.text "memo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_lending_sets_on_customer_id"
    t.index ["lending_status_id"], name: "index_lending_sets_on_lending_status_id"
  end

  create_table "lending_statuses", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "lendings", force: :cascade do |t|
    t.bigint "lending_set_id", null: false
    t.bigint "book_stock_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["book_stock_id"], name: "index_lendings_on_book_stock_id"
    t.index ["lending_set_id"], name: "index_lendings_on_lending_set_id"
  end

  create_table "ndc_categories", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "book_author_relationships", "authors"
  add_foreign_key "book_author_relationships", "book_masters"
  add_foreign_key "book_masters", "ndc_categories"
  add_foreign_key "book_stocks", "book_masters"
  add_foreign_key "book_stocks", "book_stock_statuses"
  add_foreign_key "lending_sets", "customers"
  add_foreign_key "lending_sets", "lending_statuses"
  add_foreign_key "lendings", "book_stocks"
  add_foreign_key "lendings", "lending_sets"
end
