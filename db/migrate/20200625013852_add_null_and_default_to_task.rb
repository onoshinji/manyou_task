class AddNullAndDefaultToTask < ActiveRecord::Migration[5.2]
  def change
    change_column_null :tasks, :task_name, false
    change_column_default :tasks, :task_name, from: nil, to: "default_task"
  end
end
