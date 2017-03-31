module EngineCart
  module ApplicationHelper
    def method_missing(method, *args, &block)
       return super unless (method.to_s.end_with?('_path') || method.to_s.end_with?('_url')) && main_app.respond_to?(method)
       main_app.send(method, *args)
    end
    
    def current_order
      order = Order.find_by(id: session[:order_id]) unless session[:order_id].nil?
      order ||= Order.new
    end
  end
end
