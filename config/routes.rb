Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'user_sessions#new'
  post '/login', to: 'user_sessions#create'
  delete '/logout', to: 'user_sessions#destroy'

  resources :posts do
    resources :comments, module: :posts
    resource :like, only: %i[create destroy], module: :posts
  end

  resources :users, only: %i[index] do
    resource :relationship, only: %i[create destroy], module: :users
  end

  # Defines the root path route ("/")
  root to: 'posts#index'
end
