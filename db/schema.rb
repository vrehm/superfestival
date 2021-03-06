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

ActiveRecord::Schema.define(version: 20160901080411) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "genre"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "concerts", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "stage"
    t.integer  "festival_id"
    t.integer  "artist_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "day"
    t.index ["artist_id"], name: "index_concerts_on_artist_id", using: :btree
    t.index ["festival_id"], name: "index_concerts_on_festival_id", using: :btree
  end

  create_table "events", force: :cascade do |t|
    t.integer  "timetable_id"
    t.integer  "concert_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["concert_id"], name: "index_events_on_concert_id", using: :btree
    t.index ["timetable_id"], name: "index_events_on_timetable_id", using: :btree
  end

  create_table "festivals", force: :cascade do |t|
    t.string   "name"
    t.date     "start_date"
    t.date     "end_date"
    t.string   "location"
    t.string   "photo"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timetables", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "festival_id"
    t.integer  "day"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "day_week"
    t.index ["festival_id"], name: "index_timetables_on_festival_id", using: :btree
    t.index ["user_id"], name: "index_timetables_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.boolean  "admin",                  default: false, null: false
    t.json     "hash_spotify"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "concerts", "artists"
  add_foreign_key "concerts", "festivals"
  add_foreign_key "events", "concerts"
  add_foreign_key "events", "timetables"
  add_foreign_key "timetables", "festivals"
  add_foreign_key "timetables", "users"
end
