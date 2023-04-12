Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  # devise_scope :user do
  #   get 'sign_in', to: 'devise/sessions#new'
  #   get 'sign_in', to: 'devise/sessions#new'
  #   post 'sign_in', to: 'devise/sessions#create'
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")

  root 'users#show'

  # resources :users, only: %i[clubhouses_or_user_profile show]
  # resources :clubhouses, only: %i[index]
end
