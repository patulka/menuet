Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get "weekly-menu", to: "menus#weekly_menu"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # showing all the week menus of the logged in user
  get "my-weeks", to: "week_menus#my_weeks"

  # to be able to save a week (week_menu) of the user
  resources :week_menus, only: [:create]
end
