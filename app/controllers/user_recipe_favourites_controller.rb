class UserRecipeFavouritesController < ApplicationController
  def favourite_recipes
    # showing on the favourite page the instances of recipes that the user has created when saving them
    @favourite_recipes = UserRecipeFavourite.where(user: current_user)
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @user = current_user
    # the strange syntax instead of strong_params is because we have added a link to add a favourite instead of creating a form
    @favourite_recipe = UserRecipeFavourite.new(recipe: @recipe, user: @user)
    @favourite_recipe.save

    redirect_to favourite_recipes_path
  end
end
