module EngineCart
  class OrderItem < ApplicationRecord
    belongs_to :product, class_name: EngineCart.product_class
    belongs_to :order

    validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validate :product_present, :order_present
    before_save :finalize, :set_inactive_for_coupon
    before_destroy :set_active_for_coupon
    scope :only_products, -> { joins(:product).merge(EngineCart.product_class.constantize.main) }
    scope :only_shippings, -> { joins(:product).merge(EngineCart.product_class.constantize.shippings) }
    scope :only_coupons, -> { joins(:product).merge(EngineCart.product_class.constantize.coupons) }

    def total_price
      unit_price * quantity
    end

    private

    def product_present
      errors.add(:product, 'is not valid or is not active.') if product.nil?
    end

    def order_present
      errors.add(:order, 'is not a valid order.') if order.nil?
    end

    def finalize
      self[:unit_price] = product.instance_eval(EngineCart.product_price)
    end

    def set_inactive_for_coupon
      product.update_attributes(status: 'inactive') if product.product_type == 'coupon'
    end

    def set_active_for_coupon
      product.update_attributes(status: 'active') if product.product_type == 'coupon'
    end
  end
end
