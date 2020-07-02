FactoryBot.define do
  factory :label do
    label_name { 'チーム' }
    association :task
  end

  factory :help_label ,class: Label do
    label_name { 'help' }
    #モデルにアソシエ〜ションしていることを明示する
    association :task
  end
end
