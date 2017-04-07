ENV['RAILS_ENV'] ||= 'test'

if Rails.env.production?
  abort('The Rails environment is running in production mode!')
end
require 'spec_helper'
require 'rspec/rails'
require 'pg'
require'rails-controller-testing'
require 'rectify/rspec'
require 'aasm/rspec'
require 'capybara/rspec'
require 'capybara/email/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'
require 'rack_session_access'
require 'letter_opener_web'
require 'shoulda-matchers'
require 'factory_girl_rails'
require 'ffaker'
require 'database_cleaner'


ENGINE_ROOT = File.join(File.dirname(__FILE__), '../')
%w(support factories).each do |folder|
  Dir[File.join(ENGINE_ROOT, "spec/#{folder}/**/*.rb")].each do |file|
    require file
  end
end

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Shoulda::Matchers::ActiveModel
  config.include Shoulda::Matchers::ActiveRecord
  config.include FactoryGirl::Syntax::Methods
  config.include Rectify::RSpec::Helpers
  config.include I18n

  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  
  Capybara::Webkit.configure(&:block_unknown_urls)

  Capybara.javascript_driver = :poltergeist
  # Capybara.javascript_driver = :selenium_chrome

  config.use_transactional_fixtures = false

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  Shoulda::Matchers.configure do |matcher_config|
    matcher_config.integrate do |with|
      with.test_framework :rspec
      with.library :rails
    end
  end
end
