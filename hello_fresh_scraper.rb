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


# require 'net/http'
# require 'uri'
# num = 1000
# uri = URI.parse("https://gw.hellofresh.com/api/recipes/search?offset=0&limit=#{num}&locale=en-US&country=us&author=gourmet&sort=-date")
# request = Net::HTTP::Get.new(uri)
# request["Authority"] = "gw.hellofresh.com"
# request["Sec-Ch-Ua"] = "\" Not A;Brand\";v=\"99\", \"Chromium\";v=\"90\", \"Google Chrome\";v=\"90\""
# request["Accept"] = "application/json, text/plain, */*"
# request["Authorization"] = "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2MjI2Njc4NzksImlhdCI6MTYyMDAzODEzNiwiaXNzIjoic2VuZiIsImp0aSI6IjI3ZTI0OGY0LTEwNDQtNGVmYy04NTg0LTcyNjE0ZDNiZWM1NSJ9.CaLnaa43fAJTWkLAPD2f21nPd1RyCSqNvPz9gddm7aw"
# request["Sec-Ch-Ua-Mobile"] = "?0"
# request["User-Agent"] = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36"
# request["Origin"] = "https://www.hellofresh.com"
# request["Sec-Fetch-Site"] = "same-site"
# request["Sec-Fetch-Mode"] = "cors"
# request["Sec-Fetch-Dest"] = "empty"
# request["Referer"] = "https://www.hellofresh.com/"
# request["Accept-Language"] = "cs-CZ,cs;q=0.9,en;q=0.8,fr;q=0.7,de;q=0.6"

# req_options = {
#   use_ssl: uri.scheme == "https",
# }

# response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
#   http.request(request)
# end

# recipes = JSON.parse(response.body)["items"]
# recipes.each do |recipe|
#   File.open("hf_jsons/#{recipe["id"]}.json", 'w') do |file|
#     file.write(JSON.generate(recipe))
#   end
#   i += 1
# end

