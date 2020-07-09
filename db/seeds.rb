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

  Label.create!(
      name: 'step1',
  )
  Label.create!(
      name: 'step2',
  )
  Label.create!(
      name: 'step3',
  )
  Label.create!(
      name: 'step4',
  )
  Label.create!(
      name: 'step5',
  )
