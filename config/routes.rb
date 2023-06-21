Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'clubhouses#index'

  resources :clubhouses do
    resources :posts, only: %i[new create destroy]
  end
  resources :users, only: %i[new create show destroy]

  resources :posts, only: %i[show] do
    resources :comments, only: %i[new create edit update destroy]
  end
end
