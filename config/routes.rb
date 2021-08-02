Rails.application.routes.draw do
  devise_for :renters
  devise_for :agents
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
root to: 'main#index'


get '/addprop/:id' => 'properties#new', as: :addprop
get '/displayprop', action: :show, controller: 'agent'
get '/viewprop', action: :show, controller: 'renter'

resources :properties
end
