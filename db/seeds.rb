User.create! name: "Example User", email: "example@railstutorial.org",
  password: "foobar", password_confirmation: "foobar", admin: true

49.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "foobar"
  User.create! name: name, email: email, password: password, password_confirmation: password
end
