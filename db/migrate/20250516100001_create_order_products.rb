class CreateOrderProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :order_products do |t|
      t.references :order, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :price_at_order, precision: 10, scale: 2

      t.timestamps
    end
    
    add_index :order_products, [:order_id, :product_id], unique: true
  end
end
