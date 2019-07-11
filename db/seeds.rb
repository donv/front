# frozen_string_literal: true

#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# create_table "news_items", force: true do |t|
#   t.string   "title",      limit: 64, null: false
#   t.text     "body",                  null: false
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end

Site.create! title: 'Main site', welcome_text: "Welcome\n* One\n* Two"

# create_table "users", force: true do |t|
#   t.string   "login"
#   t.string   "email"
#   t.string   "crypted_password",          limit: 40
#   t.string   "salt",                      limit: 40
#   t.string   "remember_token"
#   t.datetime "remember_token_expires_at"
#   t.datetime "created_at"
#   t.datetime "updated_at"
# end
