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

ActiveRecord::Schema[7.1].define(version: 2024_07_10_143546) do
  create_table "initiatives", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.integer "status"
    t.date "startdate"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["parent_id"], name: "index_initiatives_on_parent_id"
  end

  create_table "wyeworker_initiative_belongings", primary_key: ["wyeworker_id", "initiative_id"], force: :cascade do |t|
    t.string "kind"
    t.integer "initiative_id", null: false
    t.integer "wyeworker_id", null: false
    t.index ["initiative_id"], name: "index_wyeworker_initiative_belongings_on_initiative_id"
    t.index ["wyeworker_id"], name: "index_wyeworker_initiative_belongings_on_wyeworker_id"
  end

  create_table "wyeworkers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "initiatives", "initiatives", column: "parent_id"
  add_foreign_key "wyeworker_initiative_belongings", "initiatives"
  add_foreign_key "wyeworker_initiative_belongings", "wyeworkers"
end
