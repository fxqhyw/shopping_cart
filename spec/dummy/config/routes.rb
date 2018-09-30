Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'sessions', registrations: 'registrations' }
  resources :books
  root 'books#index'
  get '/catalog', to: 'books#index'
  get '/catalog', to: 'books#index', as: :privacy
  get '/catalog', to: 'books#index', as: :user_facebook_omniauth_authorize

  mount ShoppingCart::Engine => '/'
end
