module EngineCart
  class Engine < ::Rails::Engine
    isolate_namespace EngineCart
    
    initializer 'main_app.action_controller' do |app|
      ActiveSupport.on_load :action_controller do
        helper EngineCart::ApplicationHelper
      end
    end
  end
end
