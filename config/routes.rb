Rails.application.routes.draw do
  root "static_pages#show", page: "home"

  get "static_pages/:page", to: "static_pages#show", as: "static_page"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users, only: [:new, :create, :show]

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
end
