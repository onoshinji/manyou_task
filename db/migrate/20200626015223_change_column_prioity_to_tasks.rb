class ChangeColumnPrioityToTasks < ActiveRecord::Migration[5.2]
  def change
    # 下記の記述だと自動的に型変更にならない。エラー文にPG::DatatypeMismatch: ERROR:  column "priority" cannot be cast automatically to type integer
    # HINT:  You might need to specify "USING priority::integer".と表示される
    #change_column :tasks, :priority, :integer
    change_column :tasks, :priority, 'integer USING CAST(priority AS integer)'
  end
end
