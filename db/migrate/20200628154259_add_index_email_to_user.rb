class AddIndexEmailToUser < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :email, unique: true
    # emailのカラムにインデックスを追加
    # データベースでチェックするためにindexを設定している
  end
end
