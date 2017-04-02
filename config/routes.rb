EngineCart::Engine.routes.draw do
  resource :cart, only: [:show, :update], path_names: { show: '' }, path: '/'
  resource :checkout, only: [:show, :update]
  resources :engine_orders, :controller=>"orders", only: [:index, :show]
  root to: 'carts#show'
end
