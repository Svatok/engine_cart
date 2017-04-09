require 'rails_helper'

module EngineCart
  describe EngineCart::UpdateOrderItems do
    let(:order) { create :order, :with_items }
    let(:product) { create :product }
    let(:product2) { create :product }
    let(:coupon) { create :product, :coupon }
    subject { UpdateOrderItems.new(object: order, params: ActionController::Parameters.new(@params)) }

    before do
      @caller = double('some controller')
      allow(@caller).to receive(:session) { {order_id: order.id} }
    end

    it 'add one new product' do
      @params = { order_item: { quantity: 1, product_id: product.id } }
      subject.instance_variable_set(:@caller, @caller)
      expect { subject.call }.to change { order.reload.order_items.count }.by(1)
    end
    it 'add few new products' do
      @params = {
          order_items: {
            product.id.to_s => { quantity: 1, product_id: product.id },
            product2.id.to_s => { quantity: 1, product_id: product2.id },
          }
        }
      subject.instance_variable_set(:@caller, @caller)
      expect { subject.call }.to change { order.reload.order_items.count }.by(2)
    end
    it 'update order_item with exist product' do
      @params = { order_item: { quantity: 5, product_id: order.order_items.first.product_id } }
      subject.instance_variable_set(:@caller, @caller)
      expect { subject.call }.to change { order.reload.order_items.first.quantity }.to(6)
    end
    it 'delete one product' do
      @params = { 'delete' => 'true', 'product' => order.order_items.first.product_id.to_s }
      subject.instance_variable_set(:@caller, @caller)
      expect { subject.call }.to change { order.reload.order_items.count }.by(-1)
    end
    it 'add coupon' do
      @params = { coupon: { code: coupon.title } }
      subject.instance_variable_set(:@caller, @caller)
      expect { subject.call }.to change { order.reload.order_items.only_coupons.count }.to(1)
    end
  end
end
