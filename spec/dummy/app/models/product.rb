class Product < ApplicationRecord  
  
  has_many :order_items, class_name: 'EngineCart::OrderItem', dependent: :destroy
  has_many :orders, class_name: 'EngineCart::Order', through: :order_items

  scope :main, -> { where(product_type: 'product') }
  scope :coupons, -> { where(product_type: 'coupon') }
  scope :shippings, -> { where(product_type: 'shipping') }
end
