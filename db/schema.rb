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

ActiveRecord::Schema.define(version: 20140302071119) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: true do |t|
    t.json     "body"
    t.string   "uid"
    t.string   "url"
    t.string   "provider"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "metrics", force: true do |t|
    t.integer "activity_id"
    t.string  "type"
    t.integer "value"
  end

  create_table "program_activities", force: true do |t|
    t.integer "program_id"
    t.integer "activity_id"
  end

  create_table "programs", force: true do |t|
    t.integer  "bossanova_id"
    t.string   "keywords",     default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
