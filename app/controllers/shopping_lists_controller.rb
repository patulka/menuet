class ShoppingListsController < ApplicationController
  def destroy
    item = ShoppingList.find(params[:id])
    week_menu = item.week_menu

    item.destroy
    redirect_to shopping_list_week_menu_path(week_menu)
  end
end
