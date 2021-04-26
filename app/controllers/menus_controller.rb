class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def weekly_menu
    @menu = Recipe.all.sample(7)
  end
end
