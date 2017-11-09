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

ActiveRecord::Schema.define(version: 20171109021705) do

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
    t.text     "employee_pict_code"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "last_paid_date"
    t.date     "current_hire_date"
  end

  create_table "nd_job_lookup_employee_jobs", force: :cascade do |t|
    t.integer  "employee_id"
    t.integer  "pidm"
    t.text     "posn"
    t.text     "suffix"
    t.text     "employee_class"
    t.text     "primary"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "title"
    t.text     "status"
    t.text     "status_description"
    t.date     "last_paid"
    t.text     "orgn_code"
    t.text     "orgn_title"
    t.text     "pict_code"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
