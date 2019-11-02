Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  get '/users', to: 'users#index'
  get '/users/:id', to: 'users#show'
  get '/friends', to: 'friendships#index'
  get '/notifications', to: 'friendships#notification'
  patch '/addfriend/:id', to: 'friendships#update'
  post '/addfriend', to: 'friendships#create'
  delete '/addfriend/:id', to: 'friendships#destroy'
  resources :comments, only: [:create, :edit, :update, :destroy]
  resources :likes, only: [:create, :destroy]
  resources :posts
  root 'home#index'
end
