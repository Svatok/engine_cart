require 'rails_helper'

module EngineCart
  describe EngineCart::SetPayment do
    let(:order) { create :order, :with_items }
    let(:payment) { create :payment }
    let(:params) { { payment: attributes_for(:payment) } }

    subject { SetPayment.new(object: order, params: ActionController::Parameters.new(params)) }

    it 'return broadcast(:ok) with order if payment form valid' do
      expect { subject.call }.to broadcast(:ok, order)
    end
    it 'add payment to order' do
      expect { subject.call }.to change { order.reload.payments.count }.by(1)
    end
    it 'return broadcast(:invalid) if payment form not valid' do
      params[:payment][:card_number] = ''
      service = SetPayment.new(object: order, params: ActionController::Parameters.new(params))
      expect { service.call }.to broadcast(:invalid)
    end
  end
end
