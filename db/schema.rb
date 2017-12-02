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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20171201021743) do

  create_table "acta", :force => true do |t|
    t.string   "numero"
    t.integer  "liberal"
    t.integer  "nacional"
    t.integer  "pac"
    t.integer  "ud"
    t.integer  "dc"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "blancos"
    t.integer  "nulos"
    t.integer  "user_id"
    t.integer  "verified_count",     :default => 0
    t.boolean  "ready_for_review",   :default => true
    t.boolean  "is_sum_ok",          :default => true
    t.string   "actum_type",         :default => "p"
    t.boolean  "image_changed",      :default => false
    t.integer  "municipio_id"
    t.integer  "libre_pinu"
    t.integer  "frente_amplio"
    t.integer  "alianza_patriotica"
    t.integer  "vamos"
    t.integer  "recibidas"
    t.integer  "sobrantes"
    t.integer  "ciudadanos"
    t.integer  "miembros_mer"
    t.integer  "firmas"
  end

  add_index "acta", ["liberal", "nacional", "libre_pinu", "pac", "ud", "dc", "alianza_patriotica", "blancos", "nulos", "frente_amplio", "vamos"], :name => "acta_counts_index"
  add_index "acta", ["numero"], :name => "acta_numero_index"
  add_index "acta", ["user_id", "ready_for_review", "id", "verified_count"], :name => "acta_for_random_index"

  create_table "available_numbers", :force => true do |t|
    t.string   "numero"
    t.boolean  "has_valid_image",  :default => true
    t.boolean  "already_assigned", :default => false
    t.datetime "created_at",                          :null => false
    t.datetime "updated_at",                          :null => false
    t.string   "actum_type",       :default => "p"
  end

  create_table "departamentos", :force => true do |t|
    t.string   "name"
    t.integer  "num"
    t.integer  "from_actum"
    t.integer  "to_actum"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "municipios", :force => true do |t|
    t.string   "name"
    t.integer  "num"
    t.integer  "from_actum"
    t.integer  "to_actum"
    t.integer  "departamento_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "reportes", :force => true do |t|
    t.text     "body"
    t.integer  "user_id"
    t.integer  "acta_id"
    t.datetime "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "image"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "lastname"
    t.string   "email"
    t.string   "encrypted_password"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "provider"
    t.string   "uid"
    t.boolean  "is_admin",               :default => false
    t.integer  "acta_count",             :default => 0
    t.integer  "verifications_count",    :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "verifications", :force => true do |t|
    t.integer  "liberal"
    t.integer  "nacional"
    t.integer  "pac"
    t.integer  "ud"
    t.integer  "dc"
    t.integer  "nulos"
    t.integer  "blancos"
    t.boolean  "is_valid"
    t.integer  "acta_id"
    t.integer  "user_id"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "is_sum_ok",          :default => true
    t.boolean  "image_changed",      :default => false
    t.integer  "libre_pinu"
    t.integer  "frente_amplio"
    t.integer  "alianza_patriotica"
    t.integer  "vamos"
    t.integer  "recibidas"
    t.integer  "sobrantes"
    t.integer  "ciudadanos"
    t.integer  "miembros_mer"
    t.integer  "firmas"
  end

end
