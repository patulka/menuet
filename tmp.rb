Recipe.all.each do |recipe|
  recipe.ingredients_list.each do |ingredient|
    ingr_name = ingredient.gsub("'", "")
    ingr = Ingredient.where("name = '#{ingr_name}'")[0]
    if RecipeIngredient.where("ingredient_id = #{ingr.id}").where("recipe_id = '#{recipe.id}'") == []
      RecipeIngredient.create(recipe: recipe, ingredient: ingr)
    end
  end
end
