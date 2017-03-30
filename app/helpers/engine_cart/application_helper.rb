module EngineCart
  module ApplicationHelper
    def method_missing(method, *args, &block)
#        return super unless path_link?(method)
#        return super unless main_app.respond_to?(method) || engine_cart.respond_to?(method)
#        main_app.send(method, *args) if main_app.respond_to?(method)
#        engine_cart.send(method, *args) if engine_cart.respond_to?(method)      
      if (method.to_s.end_with?('_path') || method.to_s.end_with?('_url')) && main_app.respond_to?(method)
        main_app.send(method, *args)
      elsif (method.to_s.end_with?('_path') || method.to_s.end_with?('_url')) && engine_cart.respond_to?(method)
        self.send(method, *args)
      else
        super
      end
    end
    
    def path_link?(method)
      method.to_s.end_with?('_path') || method.to_s.end_with?('_url')
    end
  end
end
