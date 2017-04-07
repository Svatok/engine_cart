class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :title
      t.string :description
      t.float :price
      t.string :product_type

      t.timestamps
    end
  end
end
