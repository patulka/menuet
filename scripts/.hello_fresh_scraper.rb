require 'json'
files = Dir["hello_fresh_jsons_ids/*.json"]
files.each do |f|
  file = JSON.parse(File.read(f))
  title = file["name"]
  description = file["description"]
  time = [file["prepTime"]].map {|x| x[/\d+/]}[0].to_i
  url = file["websiteUrl"]
  img_url = "https://img.hellofresh.com/f_auto,fl_lossy,q_auto,w_900/hellofresh_s3" + file["imagePath"]

  ingredients = file["ingredients"].map { |ingredient| {name: ingredient["name"].downcase, hf_id: ingredient["id"] } }
  measurements = file["yields"][0]["ingredients"]
  measurements.each do |measurement|
    id = measurement["id"]
    ingredient = ingredients.find { |ingredient| ingredient[:hf_id] == id}
    ingredient[:unit] = measurement["unit"]
    ingredient[:amount] = measurement["amount"]
  end
  ingredients_string = ingredients.map { |ingredient| ingredient[:name] }.join("\n")

  recipe = Recipe.create(title: title, description: description, time: time, url: url, img_url: img_url, author: "HelloFresh.com", ingredients_string: ingredients_string)
  ingredients.each do |ingredient|
    ingr = Ingredient.where(ActiveRecord::Base::sanitize_sql_array(['name = ?', ingredient[:name]]))[0]
    ingr = Ingredient.create(name: ingredient[:name]) unless ingr
    RecipeIngredient.create(recipe: recipe, ingredient: ingr, amount: ingredient[:amount], unit: ingredient[:unit])
  end
end
