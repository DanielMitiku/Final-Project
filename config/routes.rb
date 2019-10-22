Rails.application.routes.draw do
  devise_for :users
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :posts
  root 'home#index'
end
