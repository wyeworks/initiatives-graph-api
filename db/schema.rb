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
  create_table "iniciativas", force: :cascade do |t|
    t.string "descripcion"
    t.integer "status"
    t.date "fechaInicio"
    t.integer "padre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["padre_id"], name: "index_iniciativas_on_padre_id"
  end

  create_table "pertenencia_wyeworker_iniciativas", force: :cascade do |t|
    t.integer "tipo"
    t.integer "iniciativa_id", null: false
    t.integer "wyeworker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["iniciativa_id"], name: "index_pertenencia_wyeworker_iniciativas_on_iniciativa_id"
    t.index ["wyeworker_id"], name: "index_pertenencia_wyeworker_iniciativas_on_wyeworker_id"
  end

  create_table "wyeworkers", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "iniciativas", "iniciativas", column: "padre_id"
  add_foreign_key "pertenencia_wyeworker_iniciativas", "iniciativas"
  add_foreign_key "pertenencia_wyeworker_iniciativas", "wyeworkers"
end
