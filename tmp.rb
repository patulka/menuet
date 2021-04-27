# require 'rails/all'
# require 'pry'
# require 'active_record'
# require_relative 'app/models/application_record'
# require_relative 'app/models/recipe'

require 'open-uri'
require 'json'

api_key = '92aa9785d1b94d5382a31859790e4390'
random_url = 'https://api.spoonacular.com/recipes/random?number=7'
url = random_url + "&apiKey=#{api_key}"

recipes = JSON.parse(URI.open(url).read)


puts recipes["recipes"].first["title"]

# puts recipes

# new_recipe =  Recipe.new(
#   title: "Testovaci recept",
#   description: "Dobrej recept",
#   ingredients: "sunka\nzazvor\nhouska\nmed"
#   )
# puts "ahoj"
# puts new_recipe
# puts new_recipe.ingredients_list
