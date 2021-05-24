Rails.application.routes.draw do
  devise_for :users, controllers: {
                       registrations: "users/registrations",

                     # sessions: 'users/registrations'
                     }
  root to: "listings#index"
  get "/listings/list", to: "listings#list", as: "listings_list"
  resources :listings

  resources :addresses

  get "/purchases/success", to: "purchases#success"
  # webhook routing
  post "purchases/webhook", to: "purchases#webhook"

  # get purchases index
  get "purchases/index", to: "purchases#index"
end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# end
