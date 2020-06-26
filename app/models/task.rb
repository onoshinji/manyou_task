class Task < ApplicationRecord
  # 下記の記述により、全てのクエリに対して降順で表示される。今回は、処理の早さを考慮してidでソートしてみる。
  # default_scope -> { order(created_at: :desc) }
  validates :task_name,  presence: true, length: { maximum: 80 }
  validates :content,  presence: true, length: { maximum: 300 }
  validates :time_limit, presence: true
  enum priority: { 低: 0, 中: 1, 高: 2 }
  enum status: { 未着手: 0, 着手中: 1, 完了: 2 }
end
