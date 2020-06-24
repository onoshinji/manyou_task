class Task < ApplicationRecord
  # 下記の記述により、全てのクエリに対して降順で表示される。今回は、処理の早さを考慮してidでソートしてみる。
  default_scope -> { order(created_at: :desc) }
end
