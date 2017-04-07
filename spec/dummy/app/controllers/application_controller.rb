class ApplicationController < ActionController::Base
  helper EngineCart::Engine.helpers
  
  protect_from_forgery with: :exception
end
