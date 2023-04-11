Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root 'clubhouses#index'

  resources :clubhouses
  resources :users, only: %i[new create show edit update destroy]
  resources :posts, only: %i[new create show destroy]
  resources :comments, only: %i[new create edit update destroy]
end
