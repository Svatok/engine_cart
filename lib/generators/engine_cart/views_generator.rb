module EngineCart
  class ViewsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    desc 'Generates a view files'

    def generate_views
      views_paths = EngineCart::Engine.root.join('app', 'views', 'corzinus')
      directory views_paths, 'app/views/engine_cart'
    end
  end
end
