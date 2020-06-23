class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :task_name
      t.date :time_limit
      t.string :priority

      t.timestamps
    end
  end
end
