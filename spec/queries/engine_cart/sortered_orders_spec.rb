require 'rails_helper'

module EngineCart
  describe EngineCart::SorteredOrders do
    let(:user) { create :user }

    before do
      @order1 = create :order, :with_items, state: 'in_waiting', user: user
      @order2 = create :order, :with_items, state: 'delivered', user: user
    end

    it 'when state filter not present default show in_waiting' do
      filtered_orders = SorteredOrders.new(user.orders, {})
      expect(filtered_orders.count).to eq(1)
      expect(filtered_orders.first).to eq(@order1)
    end
    it 'state filter present' do
      filtered_orders = SorteredOrders.new(user.orders, sort: 'delivered')
      expect(filtered_orders.count).to eq(1)
      expect(filtered_orders.first).to eq(@order2)
    end
  end
end
