class MenusController < ApplicationController
  skip_before_action :authenticate_user!

  def weekly_menu
    @menu = SpoonacularHelper.get_random(7)
  end
end
