Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  root 'clubhouses#index'

  resources :users, only: %i[show new create]
  resources :clubhouses, only: %i[index new create]
end
