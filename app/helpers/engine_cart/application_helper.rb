module EngineCart
  module ApplicationHelper
    def method_missing(method, *args, &block)
      return super unless method.to_s.end_with?('_path', '_url') && main_app.respond_to?(method)
       main_app.send(method, *args)
    end

    def current_order
      order = Order.find_by(id: session[:order_id]) unless session[:order_id].nil?
      order ||= Order.new
    end

    def authenticate_person!
      auth_method = "authenticate_#{EngineCart.person_class.underscore}!"
      send(auth_method) if respond_to?(auth_method)
    end

    def current_person
      resource_method = "current_#{EngineCart.person_class.underscore}"
      send(resource_method) if respond_to?(resource_method)
    end
  end
end
