class User < ApplicationRecord
  has_many :orders, class_name: 'EngineCart::Order', dependent: :destroy
end
