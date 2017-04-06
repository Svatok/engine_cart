require "engine_cart/engine"
require 'jquery-rails'
require 'turbolinks'
require 'bootstrap-sass'
require 'sass-rails'
require 'jbuilder'
require 'draper'
require 'rectify'
require 'kaminari'
require 'haml'
require 'aasm'

module EngineCart
  mattr_accessor :person_class
  @@preson_class = 'TypicalUser'

  mattr_accessor :product_class
  @@product_class = 'TypicalProduct'

  mattr_accessor :product_price
  @@product_price = 'price'

  mattr_accessor :email_order
  @@email_order = 'engine_cart@example.com'

  def self.setup
    yield self
end
end
