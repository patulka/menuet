require 'open-uri'
require 'json'

num_api_calls = 0
num_saved = 0
not_found = 0

$API_KEYS = [
  "92aa9785d1b94d5382a31859790e4390",
  "1e76ff0049ef4e449908ff45ea4cba3b",
  "cf384395a5da4ffeb2eb82fef85f79a0",
  "1d14eb12aa5c434ca5ee52d59f79ba40",
  "c7483f09e1e148e8b38b24327622d340",
  "388cbb417aa145b295405c1ab4b7bc8d",
  "c41e1a23f7564019b9318f386f359bb8"
]

$api_key_index = 0
$api_key = $API_KEYS[$api_key_index]
def get_next_api_key
  $api_key_index += 1
  if $api_key_index >= $API_KEYS.length
    raise("All API keys used up.")
  end
  $api_key = $API_KEYS[$api_key_index]
end

ingredients = Ingredient.order("LENGTH(name)").where("api_id IS NULL")

ing_id_url = 'https://api.spoonacular.com/food/ingredients/search?number=100&query='

# turn off sql logging
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

ingredients.each do |ingredient|
  ingredient = Ingredient.find(ingredient.id)
  next if ingredient.api_id

  while true
    begin
      name = ingredient.name.mb_chars.unicode_normalize(:nfkd).gsub(/[^\x00-\x7F]/n, '').downcase.to_s
      id_url = ing_id_url + name + "&apiKey=#{$api_key}"
      ids = JSON.parse(URI.open(id_url).read)["results"]
    rescue => error
      puts error
      get_next_api_key
    else
      break # all good
    end
  end
  num_api_calls += 1

  ok = false
  ids.each do |result|
    ingr = Ingredient.where(ActiveRecord::Base::sanitize_sql_array(['name = ?', result["name"].downcase]))[0]
    next unless ingr

    next if ingr.api_id

    ok = true if ingr.id == ingredient.id

    ingr.api_id = result["id"]
    ingr.img_url = "https://spoonacular.com/cdn/ingredients_100x100/#{result["image"]}"
    ingr.save
    num_saved += 1
  end

  unless ok
    ingredient.api_id = -1
    ingredient.save
    not_found += 1
    puts "WARINING: Ingredient #{ingredient.name} not found in API."
  end
  puts "saved: #{num_saved}, calls: #{num_api_calls}, not found: #{not_found}"
end

ActiveRecord::Base.logger = old_logger # turn logging back on
# unless ids == []
#   id = ids[0]["id"]

#   ing_info_url = "https://api.spoonacular.com/food/ingredients/#{id}/information?amount=1"
#   info_url = ing_info_url + "&apiKey=#{api_key}"

#   info = JSON.parse(URI.open(info_url).read)
#   aisle = info["aisle"]
#   category = info["categoryPath"]
# end

# puts ingredient
# puts aisle
# puts category
