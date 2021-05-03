Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "weekly-menu", to: "menus#weekly_menu"
  resources :recipes, only: [:show] do
    resources :user_recipe_favourites, only: [:create]
  end

  # showing all the week menus of the logged in user
  get "my-menu-plans", to: "week_menus#my_weeks"

  # showing all the favourite recipes of the logged in user
  get "favourite-recipes", to: "user_recipe_favourites#favourite_recipes"

  # to be able to save a week (week_menu) of the user
  resources :week_menus, only: [:create]

  get "faq", to: "pages#faq"
end
