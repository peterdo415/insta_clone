Rails.application.routes.draw do
  get '/posts', to: 'posts#index'
  get 'posts/new'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  # Defines the root path route ("/")
  root to: 'samples#index'
end
