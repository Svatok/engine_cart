# EngineCart::Engine.routes.draw do
Rails.application.routes.draw do
  resource :cart, only: [:show, :update], path_names: { show: '' }
  resources :orders, only: [:index, :show, :update]
  resource :checkouts, only: [:show, :update]
#   root to: 'carts#show'
end
