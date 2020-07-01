# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    task_name { 'デフォルトタイトルone' }
    content { 'Factoryで作ったデフォルトのコンテントone' }
    time_limit { Date.tomorrow }
    priority { '低' }
    status { '未着手' }
    user
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    task_name { 'デフォルトタイトルtwo' }
    content { 'Factoryで作ったデフォルトのコンテントtwo' }
    time_limit { Date.today.next_month }
    priority { '中' }
    status { '着手中' }
    user
  end

  factory :third_task, class: Task do
    task_name { 'デフォルトタイトルthree' }
    content { 'Factoryで作ったデフォルトのコンテントthree' }
    time_limit { Date.today.next_year }
    priority { '高' }
    status { '完了' }
    user
  end
end
