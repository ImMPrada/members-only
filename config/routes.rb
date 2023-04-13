Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root 'clubhouses#index'

  resources :clubhouses
  resources :users, only: %i[new create show edit update destroy]
  resources :posts, only: %i[new create show destroy]
  resources :comments, only: %i[new create edit update destroy]
end
