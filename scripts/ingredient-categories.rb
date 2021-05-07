require 'json'

# turn off sql logging
ActiveRecord::Base.logger = nil

$NEW_RELATIONS = 0

def add_relation(child, parent)
  if IngredientRelation.where(child: child, parent: parent).empty?
    IngredientRelation.create(child: child, parent: parent)
    $NEW_RELATIONS += 1
  end
end

def ingr_from_name(name)
  name = name.downcase
  Ingredient.where(ActiveRecord::Base::sanitize_sql_array(['name = ?', name]))[0] || Ingredient.create(name: name)
end

important_aisles = { "Meat" => 1391, "Cheese" => 405, "Seafood" => ingr_from_name('seafood').id, "Gluten Free" => ingr_from_name('gluten free').id, "Milk, Eggs, Other Dairy" => ingr_from_name('dairy').id }

files = Dir["ingr_info_jsons/*.json"]
files.each do |f|
  file = JSON.parse(File.read(f))

  api_id = file["id"]

  ingredients = Ingredient.where("api_id = #{api_id}").to_a
  ingredients << ingr_from_name(file["name"])

  category_path = file["categoryPath"]
  path_ingredients = category_path.map { |ingr| ingr_from_name(ingr) }

  ingredients.each do |ingredient|
    # connecting to super_parent
    if file["aisle"]
      important_aisles.each do |k, v|
        next unless file["aisle"].include? k

        super_parent = Ingredient.find(v)
        add_relation(ingredient, super_parent)
        # path_ingredients.each { |ingr| add_relation(ingr, super_parent) }
      end
    end

    # connecting ingredient to parents
    path_ingredients.each { |parent| add_relation(ingredient, parent) }

    # connecting siblings (synonyms)
    ingredients.each { |ingredient2| add_relation(ingredient, ingredient2) }
  end

  # connecting path ingredients
  for i1 in 0...path_ingredients.length
    for i2 in (i1 + 1)...path_ingredients.length
      add_relation(path_ingredients[i1], path_ingredients[i2])
    end
  end
  puts $NEW_RELATIONS
end

# connecting ingredient to itself
Ingredient.all.each do |ingr|
  add_relation(ingr, ingr)
end
