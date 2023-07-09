Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #POST "/signup"
  post "/signup", to: "users#create"

  #GET "/me"
  get "/me", to: "users#show"

  #POST "/login"
  post "/login", to: "sessions#create"

  #DELETE "/login"
  delete "/logout", to: "sessions#destroy"
end
