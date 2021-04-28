# # Used to get random recipes from Spoonacular API

# require 'open-uri'
# require 'json'

# module SpoonacularHelper
#   def self.get_random(number)
#     api_key = ENV['SPOONACULAR_API_KEY']
#     random_url = "https://api.spoonacular.com/recipes/random?number=#{number}"
#     url = random_url + "&apiKey=#{api_key}"

#     recipes_json = JSON.parse(URI.open(url).read)
#     recipes = recipes_json["recipes"]

#     recipes.map do |recipe|
#       next if Recipe.where("url = '#{recipe['sourceUrl']}'").exists?

#       ingredients = ""
#       recipe["extendedIngredients"].each do |ingredient|
#         ingredients += "#{ingredient["name"]}\n"
#       end

#       Recipe.create(
#         title: recipe["title"],
#         author: recipe["creditsText"],
#         time: recipe["readyInMinutes"].to_i,
#         img_url: recipe["image"],
#         url: recipe["sourceUrl"],
#         ingredients: ingredients,
#         instructions: recipe["instructions"]
#       )
#     end.select { |recipe| not recipe.nil? }
#   end
# end
