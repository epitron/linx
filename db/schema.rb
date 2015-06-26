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

ActiveRecord::Schema.define(version: 20150624233917) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "links", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "description"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "links", ["created_at"], name: "index_links_on_created_at", using: :btree
  add_index "links", ["description"], name: "index_links_on_description", using: :btree
  add_index "links", ["title"], name: "index_links_on_title", using: :btree
  add_index "links", ["url"], name: "index_links_on_url", using: :btree
  add_index "links", ["user_id"], name: "index_links_on_user_id", using: :btree

  create_table "links_tags", id: false, force: :cascade do |t|
    t.integer "link_id", null: false
    t.integer "tag_id",  null: false
  end

  add_index "links_tags", ["link_id"], name: "index_links_tags_on_link_id", using: :btree
  add_index "links_tags", ["tag_id"], name: "index_links_tags_on_tag_id", using: :btree

  create_table "snapshots", force: :cascade do |t|
    t.integer  "link_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "snapshots", ["link_id"], name: "index_snapshots_on_link_id", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string  "name"
    t.integer "links_count"
  end

  add_index "tags", ["links_count"], name: "index_tags_on_links_count", using: :btree
  add_index "tags", ["name"], name: "index_tags_on_name", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "username"
    t.string   "email"
    t.string   "api_key"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
