require "engine_cart/engine"
require 'jquery-rails'
require 'turbolinks'
require 'jbuilder'
require 'draper'
require 'rectify'
require 'kaminari'
require 'haml'
require 'aasm'

module EngineCart
  mattr_accessor :user_class
  @@user_class = 'TypicalUser'

  mattr_accessor :product_class
  @@product_class = 'TypicalProduct'

  mattr_accessor :product_price
  @@product_price = 'price'
  
  def self.setup
    yield self
end
end
