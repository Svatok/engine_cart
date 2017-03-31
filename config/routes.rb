EngineCart::Engine.routes.draw do
  resource :cart, only: [:show, :update], path_names: { show: '' }, path: '/'
  resources :orders, only: [:index, :show, :update]
  resource :checkouts, only: [:show, :update]
  root to: 'carts#show'
end
