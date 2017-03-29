class AddDefaultStateToEngineCartOrders < ActiveRecord::Migration[5.0]
  def up
    change_column :orders, :state, :string, default: 'cart'
  end
  def down
   change_column :orders, :state, :string, default: nil
  end
end
