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

ActiveRecord::Schema.define(version: 20131005020252) do

  create_table "documents", force: true do |t|
    t.string   "title"
    t.datetime "published_at"
    t.integer  "asset_id"
    t.string   "asset_type"
    t.string   "category"
    t.string   "original_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "plain_text"
  end

  create_table "funds", force: true do |t|
    t.string   "trading_name"
    t.string   "corporate_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "ticker"
    t.string   "bovespa_url"
  end

end
