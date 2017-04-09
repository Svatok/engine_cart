require 'rails_helper'

module EngineCart
  describe EngineCart::SetAddress do
    let(:order) { create :order, :with_items }
    let(:shipping_address) { create :shipping_address }
    let(:billing_address) { create :billing_address }
    let(:params) do
      {
          'address_forms' => {
            'billing' => attributes_for(:billing_address),
            'shipping' => attributes_for(:shipping_address)
          }
        }
    end
    subject { SetAddress.new(object: order, params: ActionController::Parameters.new(params)) }

    it 'return broadcast(:ok) with order if forms valid' do
      expect { subject.call }.to broadcast(:ok, order)
    end
    it 'create billing address' do
      subject.call
      expect(order.reload.addresses.address_with_type('billing')).to be_present
    end
    it 'create shipping address' do
      subject.call
      expect(order.reload.addresses.address_with_type('shipping')).to be_present
    end
    it 'not create billing adresses if forms not valid' do
      params['address_forms']['billing'][:first_name] = ''
      SetAddress.call(object: order, params: ActionController::Parameters.new(params))
      expect(order.reload.addresses.count).to eq(1)
    end
    it 'not create shipping adresses if forms not valid' do
      params['address_forms']['shipping'][:first_name] = ''
      SetAddress.call(object: order, params: ActionController::Parameters.new(params))
      expect(order.reload.addresses.count).to eq(1)
    end
    it 'return broadcast(:invalid) when forms not valid' do
      params['address_forms']['shipping'][:first_name] = ''
      service = SetAddress.new(object: order, params: ActionController::Parameters.new(params))
      expect { service.call }.to broadcast(:invalid)
    end

  end
end
