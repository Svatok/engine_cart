module EngineCart
  class Address < ApplicationRecord
    belongs_to :addressable, polymorphic: true
    belongs_to :country
    scope :address_with_type, ->(address_type) { find_by(address_type: address_type) }
    # scope :billing, -> { where("address_type = 'billing'").limit(1) }
    # scope :shipping, -> { where("address_type = 'shipping'").limit(1) }

  end
end
