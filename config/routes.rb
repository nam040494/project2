Rails.application.routes.draw do
  root "static_pages#show", page_type: "home"

  get "static_pages/:page_type", to: "static_pages#show", as: "static_page"

  get "/signup", to: "users#new"
  post "/signup", to: "users#create"
  resources :users do
    member do
      get :following, :followers
    end
  end

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  resources :account_activations, only: :edit
  resources :password_resets, except: %i(index show destroy)
  resources :microposts, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)
end
