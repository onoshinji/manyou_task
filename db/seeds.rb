10.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  #password_confirmationは記述しなくてもよい
  User.create!(name: name,
               email: email,
               password_digest: password,
                )
end
