EngineCart::Engine.routes.draw do
  resource :cart, only: [:show, :update], path_names: { show: '' }, path: '/'
  resource :checkouts, only: [:show, :update]
  resources :orders, only: [:index, :show], path: 'engine_orders'
  root to: 'carts#show'
end
