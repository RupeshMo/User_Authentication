Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/', to: "pages#home"
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  # get "up" => "rails/health#show", as: :rails_health_check
  get 'signup', to: "users#new"
  post '/users', to: "users#create"
  get '/users/:id', to: "users#show"
  # Defines the root path route ("/")
  # root "posts#index"  
end
