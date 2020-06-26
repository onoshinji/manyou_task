class AddNullAndDefaulotToPriority < ActiveRecord::Migration[5.2]
  def change
    change_column_null  :tasks, :priority, false
    change_column_default :tasks, :priority, from: nil, to: 0
  end
end
