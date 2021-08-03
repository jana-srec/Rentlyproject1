Rails.application.routes.draw do
  devise_for :renters
  devise_for :agents
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root to: 'main#index'


get '/addprop/:id' => 'properties#new', as: :addprop
get '/viewproperty/:id' => 'properties#show', as: :viewproperty
get '/displayprop', action: :show, controller: 'agent'
get '/viewprop', action: :show, controller: 'renter'
get '/addrentedprop/:id', action: :addrented, controller: 'properties', as: :addrentedprop
get '/addwishlist/:id', action: :addwish, controller: 'properties', as: :addwishlist
get 'rentedlistp', action: :showrented, controller: 'properties', as: :rentedlistp
get '/wishlistp', action: :showwish, controller: 'properties', as: :wishlistp

resources :properties
end
