module EngineCart
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    argument :user_model_name, required: true
    argument :product_model_name, required: true
    
    desc <<-DESC.strip_heredoc
    It do:
      1. Creates a EngineCart initializer
      2. Add engine_cart routes
      3. Create migration files
      4. Require assets
      5. Require relations to main models
      5. Include to ApplicationController engine_cart controller methods and helpers
    DESC
    
    def create_initialize_file
      template 'engine_cart.rb', 'config/initializers/engine_cart.rb'
    end

    def add_engine_cart_routes
      engine_cart_routes = 'mount EngineCart::Engine'
      return if File.readlines('config/routes.rb').grep(/#{engine_cart_routes}/).any?
      engine_cart_routes << " => '/cart'\n"
      engine_cart_routes << "  get '/orders', to: 'engine_cart/orders#index', as: :orders\n"
      engine_cart_routes << "  get '/orders/:id', to: 'engine_cart/orders#show', as: :order"
      route engine_cart_routes
    end

    def generate_migrations
      rake 'engine_cart:install:migrations'
    end

    def require_javascripts
      path = 'app/assets/javascripts/application.js'
      insert = '//= require engine_cart'
      return if File.readlines(path).grep(insert).any?
      inject_into_file path, before: '//= require_tree .' do
        "#{insert}\n"
      end
    end

    def require_stylesheets
      path = 'app/assets/stylesheets/application.css'
      insert = '*= require engine_cart\n//= require bootstrap-sprockets'
      return if File.readlines(path).grep(insert).any?
      inject_into_file path, after: ' *= require_self' do
        "\n #{insert}"
      end
    end

    def include_user_model_relationship
      user_model_class = user_model_name.underscore.camelize
      path = "app/models/#{user_model_name.underscore}.rb"
      return if File.readlines(path).grep(/has_many :orders, class_name: 'EngineCart::Order'/).any?
      inject_into_file path, after: "class #{user_model_class} < ApplicationRecord" do
        "\n  has_many :orders, class_name: 'EngineCart::Order', dependent: :destroy\n"
      end
    end

    def include_product_model_relationship
      product_model_class = product_model_name.underscore.camelize
      path = "app/models/#{product_model_class.underscore}.rb"
      return if File.readlines(path).grep(/has_many :orders, class_name: 'EngineCart::Order'/).any?
      inject_into_file path, after: "class #{product_model_class} < ApplicationRecord" do
        "\n  has_many :orders, class_name: 'EngineCart::Order', through: :order_items\n"
      end
      return if File.readlines(path).grep(/has_many :order_items, class_name: 'EngineCart::OrderItem'/).any?
      inject_into_file path, after: "class #{product_model_class} < ApplicationRecord" do
        "\n  has_many :order_items, class_name: 'EngineCart::OrderItem', dependent: :destroy"
      end
    end
    
    def include_controller_methods
      path = 'app/controllers/application_controller.rb'
      return if File.readlines(path).grep(/helper EngineCart::Engine.helpers/).any?
      inject_into_file path, after: 'class ApplicationController < ActionController::Base' do
        "\n  helper EngineCart::Engine.helpers\n"
      end
    end

    def run_migrations
      return if no? 'Do you want to run EngineCart migrations now?'
      rake 'db:migrate SCOPE=engine_cart'
    end
  end
end
