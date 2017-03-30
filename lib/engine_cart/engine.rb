module EngineCart
  class Engine < ::Rails::Engine
    isolate_namespace EngineCart
    
config.before_initialize do
  ActiveSupport.on_load :action_controller do
    helper EngineCart::ApplicationHelper
  end
end
  end
end
