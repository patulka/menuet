require 'json'
files = Dir["ingr_info_jsons/*.json"]
files.each do |f|
  file = JSON.parse(File.read(f))
  api_id = file["id"]
  category_path = file["categoryPath"]

  # prep for saving categories
end
