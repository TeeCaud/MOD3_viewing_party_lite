# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/discover', to: 'users#discover'
  root 'application#home'
  resources :users
  resources :sessions
  resources :movies
  resources :register
  resources :events
  end
#   get '/register', to: 'users#new'
#   post '/register', to: 'users#create'
#   get '/login', to: 'sessions#new'
#   post '/login', to: 'sessions#create'
#   delete '/logout', to: 'sessions#destroy'
#
#   resources :users, only: [:show] do
#     # get '/discover', to: 'users#discover'
#     # post '/discover', to: 'movies#index'
#     get '/movies', to: 'movies#index'
#   end
#   resources :movies, only: [:index, :show] do
#     get '/discover', to: 'users#discover'
#     post '/discover', to: 'movies#index'
#   end
#
#   get '/movies/:movie_id/event/new', to: 'events#new'
#   post '/users/:user_id', to: 'events#create'
# end
