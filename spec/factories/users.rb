FactoryBot.define do
  factory :user1 ,class: User do
    id { 10000 }
    name { 'sample' }
    email { 'sample1@example.com' }
    password { '00000000' }
    admin { false }
  end
  factory :user2 ,class: User do
    id { 10001 }
    name { 'sample' }
    email { 'sample2@example.com' }
    password { '00000000' }
    admin { false }
  end
  factory :admin_user, class: User do
    id { 10002 }
    name { 'admin' }
    email { 'admin@example.com' }
    password { '00000000' }
    admin { true }
  end
  factory :admin_user2, class: User do
    id { 10003 }
    name { 'admin2' }
    email { 'admin2@example.com' }
    password { '00000000' }
    admin { true }
  end
end
