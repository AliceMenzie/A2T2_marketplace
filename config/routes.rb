Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'

    # sessions: 'users/registrations'
  }
  root to: 'listings#index'
  resources :listings
  get '/purchases/success', to: 'purchases#success'
  # webhook routing
  post 'purchases/webhook', to: 'purchases#webhook'
end
# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

# end
