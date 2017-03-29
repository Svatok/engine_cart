require_dependency "engine_cart/application_controller"

module EngineCart
  class CouponForm < Rectify::Form
    attribute :code, String

  end
end
