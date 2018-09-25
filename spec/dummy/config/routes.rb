Rails.application.routes.draw do
  root to: 'products#index'
  devise_for :users
  resources :products
  mount ShoppingCart::Engine => '/'
end
