require 'rails_helper'

module EngineCart
  describe EngineCart::PrepareCheckout do
    let(:user) { create :user }
    let(:order) { create :order, :with_items }
    subject { PrepareCheckout.new(object: order, params: {}) }

    before do
      caller = double('some controller')
      allow(caller).to receive(:current_person) { user }
      allow(caller).to receive(:template_exists?) { true }
      allow(caller).to receive(:session) { {order_id: order.id} }
      subject.instance_variable_set(:@caller, caller)
      order.update_total_price!
    end

    describe 'prepare address checkout' do
      it 'return broadcast(:ok) with params for AddressPresenter' do
        expect { subject.call }.to broadcast(:ok, order, 'address', 'address')
      end
      it 'change order state to address' do
        expect { subject.call }.to change { order.reload.state }.to('address')
      end
      it 'not change order state to address if new order not valid' do
        order.update_attributes(total_price: 0)
        expect { subject.call }.not_to change { order.reload.state }
      end
    end

    describe 'prepare delivery checkout' do
      it 'return broadcast(:ok) with params for DeliveryPresenter' do
        order.update_attributes(state: 'delivery')
        expect { subject.call }.to broadcast(:ok, order, 'delivery', 'delivery')
      end
      it 'change order state to delivery if back to edit delivery' do
        order.update_attributes(state: 'confirm')
        subject.instance_variable_set(:@params, 'edit' => 'delivery')
        expect { subject.call }.to change { order.reload.state }.to('delivery')
      end
    end

    describe 'prepare payment checkout' do
      it 'return broadcast(:ok) with params for PaymentPresenter' do
        order.update_attributes(state: 'payment')
        expect { subject.call }.to broadcast(:ok, order, 'payment', 'payment')
      end
      it 'change order state to payment if back to edit payment' do
        order.update_attributes(state: 'confirm')
        subject.instance_variable_set(:@params, 'edit' => 'payment')
        expect { subject.call }.to change { order.reload.state }.to('payment')
      end
    end

    describe 'prepare confirm and complete checkout' do
      it 'return broadcast(:ok) with params for FullOrderPresenter and confirm partial' do
        order.update_attributes(state: 'confirm')
        expect { subject.call }.to broadcast(:ok, order, 'confirm', 'full_order')
      end
      it 'return broadcast(:ok) with params for FullOrderPresenter and complete partial' do
        order.update_attributes(state: 'complete')
        expect { subject.call }.to broadcast(:ok, order, 'complete', 'full_order')
      end
      it 'place order if state complete (set in_waiting state)' do
        order.update_attributes(state: 'complete')
        expect { subject.call }.to change { order.reload.state }.to('in_waiting')
      end
    end
  end
end
