require 'rails_helper'

module EngineCart
  describe CartsController, type: :controller do
    routes { EngineCart::Engine.routes }
    subject { create :order, :with_items }
    before do
      session[:order_id] = subject.id
      subject.update_total_price!
    end

    describe 'GET #show' do
      before { get :show }

      it 'render :cart template' do
        expect(response).to render_template :show
      end
      it 'respond with 200 status code' do
        expect(response).to have_http_status(200)
      end
      it '@order must be present' do
        expect(assigns(:order)).to be_present
      end
      it '@order_items must be present' do
        expect(assigns(:order_items)).to be_present
      end
    end

    describe 'PATCH #update' do
      it 'with add product' do
        order_params = {
          order_item: { quantity: '3', product_id: subject.order_items.first.id }
        }
        new_total_price = subject.order_items.first.unit_price * 3
        expect { put :update, params: order_params }.to change { subject.reload.total_price }.by(new_total_price)
      end
      it 'with update product count' do
        order_params = {
            order_items: {
              subject.order_items.first.id.to_s => { quantity: 5, product_id: subject.order_items.first.id }
            }
          }
        new_total_price = subject.order_items.first.unit_price * (5 - subject.order_items.first.quantity)
        expect { put :update, params: order_params }.to change { subject.reload.total_price }.by(new_total_price)
      end
      it 'with delete product' do
        order_params = { 'delete' => 'true', 'product' => subject.order_items.first.product_id.to_s }
        new_total_price = subject.order_items.first.total_price * -1
        expect { put :update, params: order_params }.to change { subject.reload.total_price }.by(new_total_price)
      end
      it 'with coupon add' do
        coupon = create :product, :coupon
        order_params = {
          order_item: { quantity: '0', product_id: subject.order_items.first.id },
          coupon: { code: coupon.title }
        }
        expect { put :update, params: order_params }.to change { subject.reload.total_price }.by(coupon.price)
      end
    end
  end
end
