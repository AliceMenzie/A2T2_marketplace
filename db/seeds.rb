# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

puts 'Destroying old records'
User.destroy_all

puts 'Seeding started'
puts 'Creating DB'

user1 = User.create(username: 'test',
     email:'test@test.com',
    password:'password')

4.times do
        user1.listings.create(
        name: 'test',
        description:'test description',
        price: rand(20... 2_000.0),
        category: 'test',
        status: 1
        )
      end


user1.addresses.create(
    street: 'fake',
    number: 22,
    postcode: 3000,
    state: 'VIC'
)

user2 = User.create(username: 'user2',
  email:'user2@test.com',
 password:'password')

4.times do
     user1.listings.create(
     name: 'test2',
     description:'test description2',
     price: rand(20... 2_000.0),
     category: 'test',
     status: 1
     )
   end


user2.addresses.create(
 street: 'fake2',
 number: 22,
 postcode: 3123,
 state: 'VIC'
)

puts 'Seeding complete'