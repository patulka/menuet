puts "Cleaning database"

RecipeIngredient.destroy_all
ShoppingList.destroy_all
Menu.destroy_all
WeekMenu.destroy_all
User.destroy_all
Recipe.destroy_all
Ingredient.destroy_all

puts "Seeding recipes, ingredients and connections..."

recipes_sql = File.read('db/recipes_seed.sql')
  connection = ActiveRecord::Base.connection()

  ActiveRecord::Base.transaction do
    connection.execute(recipes_sql)
  end

puts "Recipes seeded."

puts "Seeding ingredients..."

ingredients_sql = File.read('db/ingredients_seed.sql')
  connection = ActiveRecord::Base.connection()

  ActiveRecord::Base.transaction do
    connection.execute(ingredients_sql)
  end

puts "Ingredients seeded."

puts "Seeding connections..."

connections_sql = File.read('db/recipe_ingredients_seed.sql')
  connection = ActiveRecord::Base.connection()

  ActiveRecord::Base.transaction do
    connection.execute(connections_sql)
  end

puts "Connections seeded."
