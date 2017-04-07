Rails.application.routes.draw do
  mount EngineCart::Engine => "/engine_cart"
  get '/orders', to: 'engine_cart/orders#index', as: :orders
  get '/orders/:id', to: 'engine_cart/orders#show', as: :order
end
