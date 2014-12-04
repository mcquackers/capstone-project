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

ActiveRecord::Schema.define(version: 20141204145239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "areas", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "buddy_relationships", force: true do |t|
    t.integer  "user_id",                    null: false
    t.integer  "buddy_id",                   null: false
    t.boolean  "confirmed",  default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "buddy_relationships", ["user_id", "buddy_id"], name: "index_buddy_relationships_on_user_id_and_buddy_id", unique: true, using: :btree
  add_index "buddy_relationships", ["user_id"], name: "index_buddy_relationships_on_user_id", using: :btree

  create_table "buddy_request_subjects", force: true do |t|
    t.string   "requester_name", null: false
    t.integer  "requester_id",   null: false
    t.integer  "requested_id",   null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "club_membership_entries", force: true do |t|
    t.string   "user_name",        null: false
    t.string   "club_name",        null: false
    t.string   "connector_phrase", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "club_memberships", force: true do |t|
    t.integer  "member_id",  null: false
    t.integer  "club_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "club_memberships", ["member_id", "club_id"], name: "index_club_memberships_on_member_id_and_club_id", using: :btree

  create_table "clubs", force: true do |t|
    t.integer  "area_id",     null: false
    t.string   "name",        null: false
    t.string   "image_url"
    t.string   "location",    null: false
    t.text     "description", null: false
    t.integer  "admin_id",    null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "course_times", force: true do |t|
    t.integer  "user_id",             null: false
    t.integer  "course_id",           null: false
    t.integer  "duration_in_seconds", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "course_times", ["course_id"], name: "index_course_times_on_course_id", using: :btree
  add_index "course_times", ["user_id"], name: "index_course_times_on_user_id", using: :btree

  create_table "courses", force: true do |t|
    t.integer  "user_id",     null: false
    t.integer  "area_id",     null: false
    t.string   "name",        null: false
    t.float    "distance",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.text     "description", null: false
  end

  add_index "courses", ["area_id"], name: "index_courses_on_area_id", using: :btree
  add_index "courses", ["user_id"], name: "index_courses_on_user_id", using: :btree

  create_table "feed_updates", force: true do |t|
    t.integer  "user_id",    null: false
    t.integer  "entry_id",   null: false
    t.string   "entry_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "poster_id",  null: false
  end

  add_index "feed_updates", ["poster_id"], name: "index_feed_updates_on_poster_id", using: :btree
  add_index "feed_updates", ["user_id"], name: "index_feed_updates_on_user_id", using: :btree

  create_table "listings", force: true do |t|
    t.integer  "area_id",                 null: false
    t.string   "title",                   null: false
    t.integer  "user_id",                 null: false
    t.string   "category",                null: false
    t.string   "image_url",               null: false
    t.integer  "price",       default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "description"
  end

  create_table "new_course_entries", force: true do |t|
    t.integer  "course_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "new_course_entries", ["course_id"], name: "index_new_course_entries_on_course_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "user_id",      null: false
    t.integer  "subject_id",   null: false
    t.string   "subject_type", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "status_entries", force: true do |t|
    t.string   "image_url"
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",           null: false
    t.string   "password_digest", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "area_id"
    t.string   "name"
    t.integer  "age"
    t.string   "bike"
    t.string   "avatar_url"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "waypoints", force: true do |t|
    t.integer  "course_id",  null: false
    t.float    "lat",        null: false
    t.float    "lng",        null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "order",      null: false
  end

  add_index "waypoints", ["order"], name: "index_waypoints_on_order", using: :btree

end
