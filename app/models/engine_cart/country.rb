module EngineCart
  class Country < ApplicationRecord
    has_many :addresses
  end
end
