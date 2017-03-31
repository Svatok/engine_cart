module EngineCart
  module Controllable
    extend ActiveSupport::Concern

    included do
      helper_method :current_order
#      helper_method :current_person
    end

#    def authenticate_corzinus_person!
#      auth_method = "authenticate_#{Corzinus.person_class.underscore}!"
#      send(auth_method) if respond_to?(auth_method)
#    end

#    def current_person
#      resource_method = "current_#{Corzinus.person_class.underscore}"
#      send(resource_method) if respond_to?(resource_method)
#    end
    
    def current_order
      order = Order.find_by(id: session[:order_id]) unless session[:order_id].nil?
      order ||= Order.new
    end
  end
end
