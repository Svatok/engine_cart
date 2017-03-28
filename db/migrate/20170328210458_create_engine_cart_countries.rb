class CreateEngineCartCountries < ActiveRecord::Migration[5.0]
  def change
    create_table :engine_cart_countries do |t|
      t.string :name
      t.string :phone_number

      t.timestamps
    end
  end
end
