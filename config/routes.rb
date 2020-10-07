Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, expect: :index do
    resources :orders, only: [:index, :create]
    resources :comments, only: [:new, :create, :destroy]
  end
end
