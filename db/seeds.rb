require 'database_cleaner'

puts "Cleaning database"

DatabaseCleaner.clean_with(:truncation)

# IngredientRelation.destroy_all
# RecipeIngredient.destroy_all
# ShoppingList.destroy_all
# UserRecipeFavourite.destroy_all
# Menu.destroy_all
# WeekMenu.destroy_all
# Recipe.destroy_all
# Ingredient.destroy_all

puts "Seeding recipes, ingredients and connections..."

puts "Seeding recipes..."

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

puts "Seeding ingredient relations..."

relations_sql = File.read('db/ingredient_relations_seed.sql')
  connection = ActiveRecord::Base.connection()

  ActiveRecord::Base.transaction do
    connection.execute(relations_sql)
  end

puts "Ingredient relations seeded."
