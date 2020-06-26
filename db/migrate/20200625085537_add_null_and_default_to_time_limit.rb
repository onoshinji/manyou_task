class AddNullAndDefaultToTimeLimit < ActiveRecord::Migration[5.2]
  def change
    change_column_null  :tasks, :time_limit, false
    change_column_default :tasks, :time_limit, from: nil, to: Date.today.end_of_week
  end
end
