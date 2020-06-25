class AddNullAndDefaltToContent < ActiveRecord::Migration[5.2]
  def change
    #どちらのメソッドも:テーブル名, :カラム名,が共通,nullにしたい場合は、falseと記述するだけでよい。default値を設定する場合はfromとtoを設定しておく
    change_column_null :tasks, :content, false
    change_column_default :tasks, :content, from: nil, to: "default_content"
  end
end
