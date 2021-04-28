puts "Cleaning database"

Recipe.destroy_all

puts "Seeding recipes..."

sql = File.read('db/recipes_seed.sql')
  connection = ActiveRecord::Base.connection()

  ActiveRecord::Base.transaction do
    connection.execute(sql)
  end

puts "Recipes seeded."
