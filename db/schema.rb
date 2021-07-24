# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 4) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'blog_entries', force: :cascade do |t|
    t.datetime 'datetime', null: false
    t.string 'title', limit: 64, null: false
    t.text 'text', null: false
    t.integer 'blog_id', null: false
  end

  create_table 'blogs', force: :cascade do |t|
    t.string 'title', limit: 64, null: false
  end

  create_table 'images', force: :cascade do |t|
    t.integer 'blog_entry_id', null: false
    t.binary 'picture_data'
    t.string 'picture_content_type', limit: 100
  end

  create_table 'news_items', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'title', limit: 64, null: false
    t.text 'body', null: false
  end

  create_table 'routes', force: :cascade do |t|
    t.string 'name', limit: 64, null: false
  end

  create_table 'schema_info', id: false, force: :cascade do |t|
    t.integer 'version'
  end

  create_table 'sites', force: :cascade do |t|
    t.string 'title', limit: 64, null: false
    t.string 'welcome_text', limit: 255, null: false
  end

  create_table 'tours', force: :cascade do |t|
    t.datetime 'started_at', null: false
    t.time 'total_time', null: false
    t.decimal 'distance', precision: 6, scale: 2, null: false
    t.decimal 'average_speed', precision: 4, scale: 1, null: false
    t.decimal 'max_speed', precision: 4, scale: 1, null: false
    t.decimal 'calories', precision: 5, scale: 1, null: false
    t.decimal 'odo', precision: 7, scale: 1, null: false
    t.integer 'route_id', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'login', limit: 255
    t.string 'email', limit: 255
    t.string 'crypted_password', limit: 40
    t.string 'salt', limit: 40
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string 'remember_token', limit: 255
    t.datetime 'remember_token_expires_at'
  end

  create_table 'weights', force: :cascade do |t|
    t.datetime 'created_at', null: false
    t.decimal 'weight', precision: 4, scale: 1, null: false
  end

  add_foreign_key 'tours', 'routes', name: 'tours_route_id_fkey'
end
