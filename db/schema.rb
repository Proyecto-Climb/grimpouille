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

ActiveRecord::Schema[7.0].define(version: 2025_04_29_040340) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attempts", force: :cascade do |t|
    t.datetime "date"
    t.text "notes"
    t.integer "status"
    t.bigint "climb_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["climb_id"], name: "index_attempts_on_climb_id"
  end

  create_table "climbing_routes", force: :cascade do |t|
    t.string "name"
    t.string "grade"
    t.integer "style", default: 0
    t.bigint "crag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "stars", default: 0
    t.string "url"
    t.integer "height", default: 0
    t.integer "standardized_grade"
    t.index ["crag_id"], name: "index_climbing_routes_on_crag_id"
  end

  create_table "climbs", force: :cascade do |t|
    t.integer "status"
    t.bigint "climbing_route_id", null: false
    t.bigint "climber_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["climber_id"], name: "index_climbs_on_climber_id"
    t.index ["climbing_route_id"], name: "index_climbs_on_climbing_route_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.string "grading_system", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "crags", force: :cascade do |t|
    t.string "name"
    t.bigint "sector_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sector_id"], name: "index_crags_on_sector_id"
  end

  create_table "pitches", force: :cascade do |t|
    t.integer "length"
    t.integer "position"
    t.string "pitch_grade"
    t.integer "bolts"
    t.integer "angle", default: 0
    t.bigint "climbing_route_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["climbing_route_id"], name: "index_pitches_on_climbing_route_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.bigint "country_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_provinces_on_country_id"
  end

  create_table "regions", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "province_id", null: false
    t.index ["province_id"], name: "index_regions_on_province_id"
  end

  create_table "sectors", force: :cascade do |t|
    t.string "name"
    t.bigint "region_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["region_id"], name: "index_sectors_on_region_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "developer", default: false
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attempts", "climbs"
  add_foreign_key "climbing_routes", "crags"
  add_foreign_key "climbs", "climbing_routes"
  add_foreign_key "climbs", "users", column: "climber_id"
  add_foreign_key "crags", "sectors"
  add_foreign_key "pitches", "climbing_routes"
  add_foreign_key "provinces", "countries"
  add_foreign_key "regions", "provinces"
  add_foreign_key "sectors", "regions"
end
