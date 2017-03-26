$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "engine_cart/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "engine_cart"
  s.version     = EngineCart::VERSION
  s.authors     = ["Svatok"]
  s.email       = ["s_s_s@ua.fm"]
  s.homepage    = "TODO"
  s.summary     = "TODO: Summary of EngineCart."
  s.description = "TODO: Description of EngineCart."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.1"

  s.add_development_dependency "sqlite3"
end
