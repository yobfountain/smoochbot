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

ActiveRecord::Schema.define(:version => 20100913010319) do

  create_table "articles", :force => true do |t|
    t.string   "title"
    t.integer  "author_id",      :default => 1
    t.text     "intro"
    t.text     "body"
    t.integer  "duration"
    t.integer  "min_cost"
    t.integer  "max_cost"
    t.float    "rating"
    t.boolean  "can_reuse",      :default => false, :null => false
    t.boolean  "is_significant", :default => false, :null => false
    t.boolean  "active",         :default => false, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mailings", :force => true do |t|
    t.integer  "smoochee_id"
    t.integer  "article_id"
    t.datetime "time_sent"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "smoochees", :force => true do |t|
    t.string   "email"
    t.boolean  "email_verified"
    t.boolean  "active"
    t.date     "anniversary"
    t.date     "birthday"
    t.integer  "budget"
    t.integer  "frequency"
    t.datetime "last_smooched"
    t.string   "confirmation_code"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
