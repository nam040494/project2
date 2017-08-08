Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "static_pages/:page", to: "static_pages#show", as: "static_page"
  get "/signup", to: "users#new"

  root "static_pages#show", page: "home"
end
