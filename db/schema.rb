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

ActiveRecord::Schema.define(version: 20140405035117) do

  create_table "categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_videos", id: false, force: true do |t|
    t.integer "category_id", null: false
    t.integer "video_id",    null: false
  end

  add_index "categories_videos", ["category_id"], name: "index_categories_videos_on_category_id"
  add_index "categories_videos", ["video_id"], name: "index_categories_videos_on_video_id"

  create_table "groups", force: true do |t|
    t.string   "name"
    t.boolean  "with_image"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", force: true do |t|
    t.string   "name"
    t.boolean  "with_image"
    t.boolean  "with_subtitle"
    t.integer  "group_id"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "width"
    t.integer  "height"
  end

  add_index "videos", ["group_id"], name: "index_videos_on_group_id"

end
