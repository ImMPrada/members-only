# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


puts 'Creating users...'

100.times do |user_n|
  username = "user#{user_n}"
  User.create(
    username:,
    email: "user_#{user_n}@a.a"
  )

  puts "user_#{user_n} created!"
end

puts '...users created'

puts 'Creating some clubhouses...'

5.times do |clubhouse_n|
  user = User.all[clubhouse_n]
  Clubhouse.create(
    title: "clubhouse #{clubhouse_n}",
    description: "This is clubhouse #{user.username} created by db:seed",
    user:
  )

  Clubhouse.create(
    title: "TED tech talks from #{clubhouse_n}",
    description: "This is clubhouse #{user.username} created by db:seed",
    user:
  )

  Clubhouse.create(
    title: "Netflix series by #{clubhouse_n}",
    description: "This is clubhouse #{user.username} created by db:seed",
    user:
  )

  puts "clubhouses for #{user.username} created!"
end

puts '...clubhouses created'