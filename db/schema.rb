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

ActiveRecord::Schema.define(version: 20151019030650) do

  create_table "articles", force: :cascade do |t|
    t.string   "title"
    t.string   "author"
    t.string   "slug"
    t.string   "author_url"
    t.text     "first_page"
    t.text     "bio"
    t.integer  "page_count"
    t.integer  "body_width", default: 600
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.boolean  "has_index",  default: false
  end

  create_table "pages", force: :cascade do |t|
    t.integer  "page_number"
    t.string   "slug"
    t.text     "body"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "paginable_id"
    t.string   "paginable_type"
  end

  add_index "pages", ["paginable_id", "paginable_type"], name: "index_pages_on_paginable_id_and_paginable_type"

  create_table "stories", force: :cascade do |t|
    t.string   "title"
    t.string   "slug"
    t.integer  "page_count"
    t.integer  "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "stories", ["article_id"], name: "index_stories_on_article_id"

end
