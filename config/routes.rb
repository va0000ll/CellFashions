Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'
    resources :categories
    resources :products
    resources :orders, only: %i[index update destroy]
    resources :users, only: %i[index update destroy]
  end
  root to: 'home#index'
  devise_for :users
  resources :orders, only: %i[index new create show]
  resources :products, only: %i[index show]
end
