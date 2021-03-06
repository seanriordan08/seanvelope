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

ActiveRecord::Schema.define(version: 20170111001735) do

  create_table "articles", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.text     "body",       limit: 65535
    t.integer  "rating",     limit: 4
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "companies", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "company_id", limit: 4
  end

  add_index "customers", ["company_id"], name: "index_customers_on_company_id", using: :btree

  create_table "districts", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "company_id", limit: 4
  end

  add_index "districts", ["company_id"], name: "index_districts_on_company_id", using: :btree

  create_table "parts", force: :cascade do |t|
    t.string   "name",        limit: 255,             null: false
    t.string   "type",        limit: 255,             null: false
    t.string   "number",      limit: 255,             null: false
    t.string   "size",        limit: 255
    t.integer  "quantity",    limit: 4,   default: 1
    t.string   "order",       limit: 255,             null: false
    t.integer  "revenue",     limit: 4,   default: 0
    t.datetime "date_sold"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "district_id", limit: 4
  end

  add_index "parts", ["district_id"], name: "index_parts_on_district_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "email",      limit: 255
    t.string   "question",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "reservations", force: :cascade do |t|
    t.integer  "well_id",    limit: 4
    t.integer  "part_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.integer  "quantity",   limit: 4
  end

  add_index "reservations", ["part_id"], name: "index_reservations_on_part_id", using: :btree
  add_index "reservations", ["well_id"], name: "index_reservations_on_well_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.string   "role",                   limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "first_name",             limit: 255,              null: false
    t.string   "last_name",              limit: 255,              null: false
    t.integer  "company_id",             limit: 4
  end

  add_index "users", ["company_id"], name: "index_users_on_company_id", using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "wells", force: :cascade do |t|
    t.string   "name",             limit: 255,                 null: false
    t.string   "number",           limit: 255,                 null: false
    t.datetime "est_start"
    t.datetime "actual_start"
    t.boolean  "cemented",                     default: false, null: false
    t.integer  "revenue",          limit: 4,   default: 0
    t.string   "comments",         limit: 255
    t.integer  "customer_id",      limit: 4
    t.integer  "district_id",      limit: 4
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
    t.string   "directions",       limit: 255
    t.datetime "est_end"
    t.datetime "completed"
    t.string   "pump_down_ring",   limit: 255
    t.integer  "percent_complete", limit: 4,   default: 0
  end

  add_index "wells", ["customer_id"], name: "index_wells_on_customer_id", using: :btree
  add_index "wells", ["district_id"], name: "index_wells_on_district_id", using: :btree

  add_foreign_key "customers", "companies"
  add_foreign_key "districts", "companies"
  add_foreign_key "parts", "districts"
  add_foreign_key "reservations", "parts"
  add_foreign_key "reservations", "wells"
  add_foreign_key "users", "companies"
  add_foreign_key "wells", "customers"
  add_foreign_key "wells", "districts"
end
