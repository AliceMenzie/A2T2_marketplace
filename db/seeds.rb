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

user1 = User.create(username: "User1",
                    email: "User1@test.com",
                    password: "password")

3.times do
  user1.listings.create(
    name: "Face Masks",
    description: "Pack of 5 handmade facemasks",
    price: rand(10...100.0),
    category: "Clothing",
    status: 1,
  )
end



user1.addresses.create(
  street: "Fake",
  number: 22,
  postcode: 3000,
  suburb: "Melbourne",
  state: "VIC",
)

user2 = User.create(username: "User2",
                    email: "User2@test.com",
                    password: "password")

3.times do
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
  suburb: "Hawthorne East",
  state: "VIC",
)

user3 = User.create(username: "User3",
                    email: "User3@test.com",
                    password: "password")

3.times do
  user3.listings.create(
    name: "Pillow",
    description: "Knitted Pineapple pillow",
    price: rand(40.0...50.0),
    category: "Home",
    status: 1,
  )
end

user3.addresses.create(
  street: "fake3",
  number: 22,
  postcode: 3123,
  suburb: "Hawthorne East",
  state: "VIC",
)

# USER4 Start

user4 = User.create(username: "User4",
                    email: "User4@test.com",
                    password: "password")

4.times do
  user4.listings.create(
    name: "Bike Accessories",
    description: "Random assortment of bike accessories",
    price: rand(40.0...50.0),
    category: "Sport",
    status: 1,
  )
end

user4.addresses.create(
  street: "fake4",
  number: 22,
  postcode: 3123,
  suburb: "Melbourne",
  state: "VIC",
)
puts "Seeding complete"
