User.create!(
  name:  "管理者1",
  email: "admin1@example.jp",
  password:  "admin1",
  password_confirmation: "admin1",
  admin: true)
User.create!(
  name:  "管理者2",
  email: "admin2@example.jp",
  password:  "admin2",
  password_confirmation: "admin2",
  admin: true)
User.create!(
  name:  "pengin",
  email: "pengin@mail.com",
  password:  "pengin",
  password_confirmation: "pengin",
  admin: false)
User.create!(
  name:  "obake",
  email: "obake@mail.com",
  password:  "obake!",
  password_confirmation: "obake!",
  admin: false)
Label.create!(label_name: "チーム")
Label.create!(label_name: "help")
Label.create!(label_name: "難易度")
