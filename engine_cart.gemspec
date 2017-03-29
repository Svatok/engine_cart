$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "engine_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "engine_cart"
  s.version     = EngineCart::VERSION
  s.authors     = ["Svatok"]
  s.email       = ["s_s_s@ua.fm"]
  s.homepage    = "https://github.com/Svatok/engine_cart/edit/dev/"
  s.summary     = "Summary of EngineCart."
  s.description = "Cart for e-store."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"
  s.add_dependency 'jquery-rails'
  s.add_dependency 'turbolinks', '~> 5'
  s.add_dependency 'jbuilder', '~> 2.5'
  # s.add_dependency 'draper', github: 'audionerd/draper', branch: 'rails5'
  s.add_dependency 'rectify'
  s.add_dependency 'kaminari'
  s.add_dependency 'aasm'
  s.add_dependency 'haml'

  s.add_development_dependency 'pg'
  s.add_development_dependency 'rspec-rails'
  s.add_development_dependency 'rails-controller-testing'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'capybara-email'
  s.add_development_dependency 'email_spec'
  s.add_development_dependency 'capybara-screenshot'
  s.add_development_dependency 'poltergeist'
  s.add_development_dependency 'factory_girl_rails'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'database_cleaner'
  s.add_development_dependency 'shoulda-matchers'
  s.add_development_dependency 'letter_opener_web'
  # s.add_development_dependency 'capybara-webkit'
  s.add_development_dependency 'rack_session_access'
end
