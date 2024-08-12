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

ActiveRecord::Schema[7.1].define(version: 2024_08_09_125904) do
  create_table "initiative_helpers", primary_key: ["helper_id", "initiative_id"], force: :cascade do |t|
    t.integer "initiative_id", null: false
    t.integer "helper_id", null: false
    t.datetime "created_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.datetime "updated_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["helper_id"], name: "index_initiative_helpers_on_helper_id"
    t.index ["initiative_id"], name: "index_initiative_helpers_on_initiative_id"
  end

  create_table "initiatives", force: :cascade do |t|
    t.string "title", null: false
    t.string "description"
    t.integer "status"
    t.date "startdate"
    t.integer "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.integer "source_id", null: false
    t.index ["parent_id"], name: "index_initiatives_on_parent_id"
    t.index ["source_id"], name: "index_initiatives_on_source_id"
    t.index ["title"], name: "index_initiatives_on_title", unique: true
  end

  create_table "wyeworkers", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "type"
    t.index ["name"], name: "index_wyeworkers_on_name", unique: true
  end

  add_foreign_key "initiative_helpers", "initiatives", on_delete: :cascade
  add_foreign_key "initiative_helpers", "wyeworkers", column: "helper_id", on_delete: :cascade
  add_foreign_key "initiatives", "initiatives", column: "parent_id"
  add_foreign_key "initiatives", "wyeworkers", column: "source_id"
end
