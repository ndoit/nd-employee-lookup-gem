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

ActiveRecord::Schema.define(version: 20161103142157) do

  create_table "nd_employee_lookup_employees", force: :cascade do |t|
    t.text     "net_id"
    t.text     "nd_id"
    t.text     "last_name"
    t.text     "first_name"
    t.text     "middle_init"
    t.text     "primary_title"
    t.text     "employee_status"
    t.text     "home_orgn"
    t.text     "home_orgn_desc"
    t.integer  "pidm"
    t.text     "ecls_code"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
