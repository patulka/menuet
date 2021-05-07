require 'open-uri'
require 'json'

num_api_calls = 0
num_saved = 0
not_found = 0

$API_KEYS = [
  ENV["SPOONACULAR_API_KEY_1"],
  ENV["SPOONACULAR_API_KEY_2"],
  ENV["SPOONACULAR_API_KEY_3"],
  ENV["SPOONACULAR_API_KEY_4"],
  ENV["SPOONACULAR_API_KEY_5"],
  ENV["SPOONACULAR_API_KEY_6"],
  ENV["SPOONACULAR_API_KEY_7"],
  ENV["SPOONACULAR_API_KEY_8"],
  ENV["SPOONACULAR_API_KEY_9"],
  ENV["SPOONACULAR_API_KEY_10"],
  ENV["SPOONACULAR_API_KEY_11"]
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

# looking up ingredients with api id
api_ids = Ingredient.where("api_id > -1").distinct.pluck(:api_id)

# turn off sql logging
old_logger = ActiveRecord::Base.logger
ActiveRecord::Base.logger = nil

# main thing
api_ids.each do |api_id|
  ing_info_url = "https://api.spoonacular.com/food/ingredients/#{api_id}/information?amount=1"
  next if File.exist?("ingr_info_jsons/#{api_id}.json")
  while true
    # trying current API key and calling API
    begin
      info_url = ing_info_url + "&apiKey=#{$api_key}"
      info = JSON.parse(URI.open(info_url).read)
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


  File.open("ingr_info_jsons/#{api_id}.json", 'w') do |file|
    file.write(JSON.generate(info))
    num_saved += 1
  end

  puts "saved: #{num_saved}, calls: #{num_api_calls}"
end

ActiveRecord::Base.logger = old_logger # turn logging back on

