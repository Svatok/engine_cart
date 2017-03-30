module EngineCart
  class Engine < ::Rails::Engine
    isolate_namespace EngineCart
    
    config.before_initialize do
      ActiveSupport.on_load :action_controller do
        helper EngineCart::Engine.helpers
      end
    end
  end
end
