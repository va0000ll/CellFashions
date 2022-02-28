Rails.application.routes.draw do
  namespace :admin do
    root to: 'home#index'
    resources :categories
    resources :products
    resources :orders, only: %i[index update show destroy]
    resources :users, only: %i[index update show destroy] do
      member do
        get :toggle_status
      end
    end
  end
  root to: 'home#index'
  devise_for :users
  resources :orders, only: %i[index new create show]
  resources :products, only: %i[index show]
  resources :checkout, only: %i[] do
    collection do
      get :cancel
      get :success
      get '', action: :new
    end
  end

  resources :carts, only: %i[index create destroy] do
    member do
      get :increment
      get :decrement
    end
  end
end
