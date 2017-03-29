module EngineCart
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    def current_order
      order = Order.find_by(id: session[:order_id]) unless session[:order_id].nil?
      order ||= Order.new
    end
  end
end
