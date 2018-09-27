Rails.application.routes.draw do
  get '/catalog', to: 'products#index'
  devise_for :users
  resources :products
  get '/catalog', to: 'products#index', as: :user_facebook_omniauth_authorize
  get '/catalog', to: 'products#index', as: :new_user_password

  mount ShoppingCart::Engine => '/'
end
