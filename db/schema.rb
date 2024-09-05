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

ActiveRecord::Schema[7.2].define(version: 2024_09_05_114943) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_masters", force: :cascade do |t|
    t.string "isbn"
    t.string "title"
    t.date "publication_date"
    t.bigint "ndc_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ndc_category_id"], name: "index_book_masters_on_ndc_category_id"
  end

  create_table "ndc_categories", force: :cascade do |t|
    t.string "name"
    t.integer "number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "book_masters", "ndc_categories"
end
