class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.decimal :price, precision: 10, scale: 2
      t.integer :purchase_count, default: 0
      t.integer :pending_purchase_count, default: 0
      t.integer :stock_count, default: 0

      t.timestamps
    end
  end
end
