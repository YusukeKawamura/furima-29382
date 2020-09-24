Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  resources :items, expect: :index do
    resources :orders, only: :index
  end
end
