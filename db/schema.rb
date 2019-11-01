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

ActiveRecord::Schema.define(version: 20170801215156) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "round_distances", force: :cascade do |t|
    t.integer "distance"
    t.integer "ends"
    t.integer "arrows_per_end"
    t.bigint "round_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "target_size"
    t.index ["round_id"], name: "index_round_distances_on_round_id"
  end

  create_table "rounds", force: :cascade do |t|
    t.string "name"
    t.boolean "indoor"
    t.boolean "metric"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_rounds_on_name", unique: true
  end

  add_foreign_key "round_distances", "rounds"
end
