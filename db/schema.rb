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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101117045817) do

  create_table "habit_days", :force => true do |t|
    t.integer  "habit_id"
    t.date     "date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "habit_days", ["date"], :name => "index_habit_days_on_date"
  add_index "habit_days", ["habit_id"], :name => "index_habit_days_on_habit_id"

  create_table "habits", :force => true do |t|
    t.integer  "user_id"
    t.date     "start_date"
    t.string   "what"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "habits", ["start_date"], :name => "index_habits_on_start_date"
  add_index "habits", ["user_id"], :name => "index_habits_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin"
    t.string   "facebook_identifier"
    t.string   "facebook_access_token"
    t.string   "username"
    t.string   "password"
    t.string   "phone_number"
  end

  add_index "users", ["facebook_identifier"], :name => "index_users_on_facebook_identifier"
  add_index "users", ["phone_number"], :name => "index_users_on_phone_number"
  add_index "users", ["username"], :name => "index_users_on_username"

end
