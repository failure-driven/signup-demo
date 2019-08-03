Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: %i[new create]
  get '/users/:username' => 'users#show', as: :user
  get '/users' => 'users#index', as: :user_root # creates user_root_path

  namespace :api do
    get 'attempt', to: 'usernames#attempt'
  end

  root to: 'users#index'
end
