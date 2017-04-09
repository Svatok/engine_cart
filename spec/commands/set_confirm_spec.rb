require 'rails_helper'

module EngineCart
  describe EngineCart::SetDelivery do
    let(:order) { create :order, :with_items }
    subject { SetConfirm.new(object: order, params: {}) }

    before do
      subject.stub(:send_letter_with_order_details) { true }
    end

    it 'return broadcast(:ok) after order confirm' do
      expect { subject.call }.to broadcast(:ok, order)
    end
    it 'set order number after confirm' do
      expect { subject.call }.to change { order.reload.order_number }
    end
  end
end
