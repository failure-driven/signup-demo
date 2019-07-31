Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: %i[new create]
  get '/users/:username' => 'users#show', as: :user
  get '/users', to: redirect('/')

  namespace :api do
    get 'attempt', to: 'usernames#attempt'
  end

  root to: 'users#new'
end
