EngineCart::Engine.routes.draw do
  resource :cart, only: [:show, :update], path_names: { show: '' }, path: '/'
  resource :checkouts, only: [:show, :update]
  root to: 'carts#show'
end
