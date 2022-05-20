ActiveRecord::Schema.define(version: 20160324170132) do

  create_table "lists", force: :cascade do |t|
    t.string  "name"
    t.integer "user_id"
  end

  create_table "tasks", force: :cascade do |t|
    t.string  "name"
    t.integer "list_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
  end

end
