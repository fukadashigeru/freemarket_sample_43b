Rails.application.routes.draw do
  devise_for :users
  get "ads" => "users#edit"
  root 'items#index'
  get "users/registration" => "users#registration"
  get "users/select" => "users#select"
  resources :items
  resources :users
  resources :regions
  resources :brands
  resources :categorys
  resources :credits
end
