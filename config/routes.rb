Rails.application.routes.draw do
  get 'recipes/show'
  devise_for :users
  root to: 'pages#home'
  get "weekly-menu", to: "menus#weekly_menu"
  resources :recipes, only: [:show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
