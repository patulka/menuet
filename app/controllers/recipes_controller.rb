class RecipesController < ApplicationController
  skip_before_action :authenticate_user!
  def show
    @recipe = Recipe.find(params[:id])
  end
end
