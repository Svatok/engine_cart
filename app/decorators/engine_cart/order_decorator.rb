require_dependency "engine_cart/application_controller"

module EngineCart
  class OrderDecorator < Draper::Decorator
    delegate_all

    def discount
      object.coupon_sum * -1
    end

    def subtotal_price
      object.total_price ||= 0
      object.total_price - object.coupon_sum - object.shipping_cost
    end
    
    def full_name
      return '' unless object.addresses.present?
      object.addresses.first.first_name + ' ' + object.addresses.first.last_name
    end
  end
end
