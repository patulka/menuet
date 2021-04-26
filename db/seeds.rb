# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Cleaning database"
# Recipes.destroy_all

puts "Seeding recipes..."


10.times do
  recipe = Recipe.create!(
    title: Faker::Ancient.god + " soup",
    description: "Very delicious."
    )
end

puts "Recipes seeded."
