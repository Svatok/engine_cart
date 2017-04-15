require 'rails_helper'

module EngineCart
  describe EngineCart::SetDelivery do
    let(:order) { create :order, :with_items }
    let(:shipping) { create :product, :shipping }
    let(:params) { { 'shippings_' => { 'product' => shipping.id } } }
    subject { SetDelivery.new(object: order, params: ActionController::Parameters.new(params)) }

    it 'return broadcast(:ok) with order if shipping selected' do
      expect { subject.call }.to broadcast(:ok, order)
    end
    it 'add shipping order_item to order' do
      expect { subject.call }.to change { order.reload.order_items.only_shippings.count }.by(1)
    end
    it 'return broadcast(:invalid) if shipping not selected' do
      expect { SetDelivery.call(object: order, params: {}) }.to broadcast(:invalid)
    end

  end
end
