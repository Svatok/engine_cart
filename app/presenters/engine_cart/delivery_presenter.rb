module EngineCart
  class DeliveryPresenter < Rectify::Presenter
    attribute :object

    def available_shippings
      EngineCart.product_class.constantize.shippings
    end

    def current_order_shipping
      object_has_errors? ? object : object_without_errors
    end

    private

    def object_has_errors?
      object.is_a?(OrderItem)
    end

    def object_without_errors
      object.deliveries.present? ? object.deliveries.first : object.order_items.new
    end
  end
end
