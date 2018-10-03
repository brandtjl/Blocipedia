# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

5.times do
    User.create!(
    email:    Faker::Internet.email,
    password: Faker::Internet.password,
    role: 'user',
    account_type: 'free'
    )
  end

2.times do
    User.create!(
        email:    Faker::Internet.email,
        password: Faker::Internet.password,
        role: 'admin',
        account_type: 'premium'
        )
end

User.create!(
    email: 'jdbrandt4@hotmail.com',
    password: 'password',
    role: 'admin',
    account_type: 'premium'
    )

  users = User.all

  25.times do
    Wiki.create!(
        title: Faker::Lorem.sentence,
        body: Faker::Lorem.paragraph,
        private: Faker::Boolean.boolean(0.5),
        user: users.sample
    )
  end 