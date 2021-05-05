require 'open-uri'
require 'json'

num_api_calls = 0
num_saved = 0
not_found = 0

$API_KEYS = [
  ENV[SPOONACULAR_API_KEY_1],
  ENV[SPOONACULAR_API_KEY_2],
  ENV[SPOONACULAR_API_KEY_3],
  ENV[SPOONACULAR_API_KEY_4],
  ENV[SPOONACULAR_API_KEY_5],
  ENV[SPOONACULAR_API_KEY_6],
  ENV[SPOONACULAR_API_KEY_7],
  ENV[SPOONACULAR_API_KEY_8]
]

# sets up new API key if the current one reached limit
$api_key_index = 0
$api_key = $API_KEYS[$api_key_index]
def get_next_api_key
  $api_key_index += 1
  if $api_key_index >= $API_KEYS.length
    raise("All API keys used up.")
  end
  $api_key = $API_KEYS[$api_key_index]
end

# looking up ingredients without api id
ingredients = Ingredient.order("LENGTH(name)").where("api_id IS NULL")

ing_id_url = 'https://api.spoonacular.com/food/ingredients/search?number=100&query='

# turn off sql logging
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

# main thing
ingredients.each do |ingredient|
  ingredient = Ingredient.find(ingredient.id)
  next if ingredient.api_id

  while true
    # trying current API key and calling API
    begin
      name = ingredient.name.mb_chars.unicode_normalize(:nfkd).gsub(/[^\x00-\x7F]/n, '').downcase.to_s
      id_url = ing_id_url + name + "&apiKey=#{$api_key}"
      ids = JSON.parse(URI.open(id_url).read)["results"]
    # catching if API key doesn't work
    rescue => error
      puts error
      # getting new API key and trying again
      get_next_api_key
    # API key works, main thing can contonue
    else
      break
    end
  end

  # just for terminal messages
  num_api_calls += 1

  ok = false
  ids.each do |result|
    # dealing with special charachters, finding if found ingredient by API is in our DB
    ingr = Ingredient.where(ActiveRecord::Base::sanitize_sql_array(['name = ?', result["name"].downcase]))[0]
    next unless ingr

    next if ingr.api_id

    ok = true if ingr.id == ingredient.id

    # setting up api_id and img_url
    ingr.api_id = result["id"]
    ingr.img_url_ingr = "https://spoonacular.com/cdn/ingredients_100x100/#{result["image"]}"
    ingr.save
    num_saved += 1
  end

  # ingredient not in our DB, put set -1 as api_id and show error message in terminal
  unless ok
    ingredient.api_id = -1
    ingredient.save
    not_found += 1
    puts "WARINING: Ingredient #{ingredient.name} not found in API."
  end

  # showing results of API call
  puts "saved: #{num_saved}, calls: #{num_api_calls}, not found: #{not_found}"
end

ActiveRecord::Base.logger = old_logger # turn logging back on
