# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts "Destroying old records"
Purchase.destroy_all
User.destroy_all

puts "Seeding started"
puts "Creating DB"

user1 = User.create(username: "Vera444",
                    email: "test@test.com",
                    password: "password")

2.times do
  user1.listings.create(
    name: "Face Masks",
    description: "Pack of 5 handmade facemasks",
    price: rand(10...100.0),
    category: "Clothing",
    status: 1,
  )
end

user1.addresses.create(
  street: "fake",
  number: 22,
  postcode: 3000,
  suburb: 'melbourne',
  state: "VIC",
)

user2 = User.create(username: "reg222",
                    email: "test2@test.com",
                    password: "password")

2.times do
  user2.listings.create(
    name: "Button Down Shirt",
    description: "Pack of Two Mens Button down Shirts, Large",
    price: rand(40.0...50.0),
    category: "Clothing",
    status: 1,
  )
end

user2.addresses.create(
  street: "fake2",
  number: 22,
  postcode: 3123,
  state: "VIC",
)

puts "Seeding complete"
