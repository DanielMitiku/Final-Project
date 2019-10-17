Rails.application.routes.draw do
  get '/users', to: 'users#index'
  resources :posts
  devise_for :users
  root 'home#index'
end
