ShoppingCart::Engine.routes.draw do
  resources :order_items, only: %i[create update destroy]
  resource :cart, only: %i[show update]
  resources :orders, only: %i[index show]
  resources :checkouts
  scope '/settings' do
    resource :address, only: :update
    get '/address', to: 'addresses#edit'
  end
end
