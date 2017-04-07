module EngineCart
  describe EngineCart::PrepareCheckout do
    let(:user) { create :user }
    let(:order) { create :order, :with_items }
    
    describe 'prepare address checkout' do
      let(:params) {  { delivery_id: delivery.id } }
      subject { PrepareCheckout.new(order: order, params: params) }

    end
    
    describe 'prepare shipping checkout' do
    end    
    
    describe 'prepare payment checkout' do
    end
    
    describe 'prepare confirm and complete checkout' do
    end   
  end
end
