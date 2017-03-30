module EngineCart
  module ApplicationHelper
    def method_missing(method, *args, &block)
       return super unless (method.to_s.end_with?('_path') || method.to_s.end_with?('_url')) && main_app.respond_to?(method)
       main_app.send(method, *args)
    end
  end
end
