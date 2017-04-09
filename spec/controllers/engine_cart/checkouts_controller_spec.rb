require 'rails_helper'

module EngineCart
  describe CheckoutsController, type: :controller do
    routes { EngineCart::Engine.routes }
    subject { create :order, :with_items }
    let(:user) { create :user }
    before do
      allow(controller).to receive(:current_person) { user }
      session[:order_id] = subject.id
      subject.update_total_price!
    end

    describe 'GET #show' do
      it 'change to address state when state cart' do
        get :show
        expect(subject.reload.state).to eq('address')
      end

      describe 'render :show checkout' do
        %i(address delivery payment confirm complete).each do |order_state|
          before do
            subject.update_attributes(state: order_state)
            get :show
          end

          it 'render :checkout template' do
            expect(response).to render_template :show
          end
          it '@order must be present' do
            expect(assigns(:order)).to be_present
          end
        end
      end

      it 'change to in_waiting state when state complete' do
        subject.update_attributes(state: 'complete')
        get :show
        expect(subject.reload.state).to eq('in_waiting')
      end
    end

    describe 'PATCH #update' do
      let(:shipping_address) { create :shipping_address }
      let(:billing_address) { create :billing_address }
      let(:shipping) { create :product, :shipping }

      it 'change state to delivery when current state address' do
        params = {
          'address_forms' => {
            'billing' => attributes_for(:billing_address),
            'shipping' => attributes_for(:shipping_address)
          }
        }
        subject.update_attributes(state: 'address')
        put :update, params: params
        expect(subject.reload.state).to eq('delivery')
      end
      it 'change state to payment when current state delivery' do
        params = { 'shippings_' => { 'product' => shipping.id } }
        subject.update_attributes(state: 'delivery')
        put :update, params: params
        expect(subject.reload.state).to eq('payment')
      end
    end
  end
end
