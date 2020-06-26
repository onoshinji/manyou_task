
ActiveRecord::Schema.define(version: 2020_06_26_015223) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "tasks", force: :cascade do |t|
    t.string "task_name", default: "default_task", null: false
    t.date "time_limit", default: "2020-06-28", null: false
    t.integer "priority"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "content", default: "default_content", null: false
  end

end
