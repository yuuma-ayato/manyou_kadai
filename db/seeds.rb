User.create!(
  name:  "admin",
  email: "aaa@example.jp",
  password: "123456",
  password_confirmation: "123456",
  admin: true)

User.create!(
  name:  "user",
  email: "bbb@example.jp",
  password: "123456",
  password_confirmation: "123456",
  admin: false)
