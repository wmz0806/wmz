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

ActiveRecord::Schema.define(:version => 20120518012323) do

  create_table "articles", :force => true do |t|
    t.string   "title",          :default => "无标题"
    t.text     "info"
    t.integer  "read_number",    :default => 0
    t.integer  "reprint_number", :default => 0
    t.string   "reprint_path"
    t.boolean  "is_img",         :default => false
    t.boolean  "is_video"
    t.integer  "home_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "info"
    t.integer  "user_id"
    t.integer  "article_id"
    t.integer  "home_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "dressups", :force => true do |t|
    t.string   "background",      :default => "#000000"
    t.string   "background_img",  :default => "/def_img/dressup/1/bg.gif"
    t.string   "menu_bg",         :default => "/def_img/dressup/1/menu.gif"
    t.string   "module_bg",       :default => "/def_img/dressup/1/module_bg.jpg"
    t.string   "a_before",        :default => "#ffffff"
    t.string   "a_after",         :default => "#808080"
    t.string   "module_title_bg", :default => "/def_img/dressup/1/module_title.gif"
    t.string   "article_bg_up",   :default => "/def_img/dressup/1/article_up.gif"
    t.string   "article_bg_down", :default => "/def_img/dressup/1/article_down.gif"
    t.string   "up_scene",        :default => "/def_img/dressup/1/up.jpg"
    t.string   "down_scene",      :default => "/def_img/dressup/1/down.jpg"
    t.string   "font_color",      :default => "#808080"
    t.string   "title",           :default => "未命名"
    t.string   "img_path",        :default => "/def_img/dressup/1/img.gif"
    t.integer  "hot",             :default => 0
    t.datetime "created_at",                                                         :null => false
    t.datetime "updated_at",                                                         :null => false
  end

  create_table "homes", :force => true do |t|
    t.string   "title"
    t.integer  "rank",         :default => 1
    t.integer  "visit",        :default => 0
    t.integer  "exp",          :default => 0
    t.integer  "attention",    :default => 0
    t.boolean  "is_img",       :default => false
    t.boolean  "is_music",     :default => false
    t.string   "visitor_list"
    t.integer  "user_id"
    t.integer  "dressup_id",   :default => 1
    t.datetime "created_at",                      :null => false
    t.datetime "updated_at",                      :null => false
  end

  create_table "message_boards", :force => true do |t|
    t.text     "info"
    t.integer  "user_id"
    t.integer  "home_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "photo_albums", :force => true do |t|
    t.string   "pa_name",    :default => "相册"
    t.string   "info",       :default => "暂无介绍"
    t.string   "cover",      :default => "/def_img/photo/cover/cover.png"
    t.integer  "home_id"
    t.datetime "created_at",                                               :null => false
    t.datetime "updated_at",                                               :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "p_name"
    t.string   "info",           :default => "暂无介绍"
    t.integer  "photo_album_id"
    t.string   "p_path"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "hash_pwd"
    t.string   "salt"
    t.integer  "sex"
    t.integer  "age"
    t.string   "address"
    t.string   "head_img",   :default => "/def_img/head/head.jpg"
    t.text     "info"
    t.datetime "birthday"
    t.string   "real_name"
    t.string   "email"
    t.datetime "created_at",                                       :null => false
    t.datetime "updated_at",                                       :null => false
  end

end
