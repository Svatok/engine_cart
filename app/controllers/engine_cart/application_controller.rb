module EngineCart
  class ApplicationController < ::ApplicationController
    layout 'layouts/application'
    protect_from_forgery with: :exception
    include ApplicationHelper
  end
end
