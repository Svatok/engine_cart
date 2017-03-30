module EngineCart
  class Engine < ::Rails::Engine
    isolate_namespace EngineCart
    
    config.to_prepare do
      EngineCart::ApplicationController.helper Rails.application.helpers
    end
  end
end
