module EngineCart
  class Payment < ApplicationRecord
    belongs_to :order
  end
end
