class CreateOrders < ActiveRecord::Migration[8.0]
  def change
    create_table :orders do |t|
      t.string :status, default: 'pending'
      t.decimal :total_amount, precision: 10, scale: 2, default: 0

      t.timestamps
    end

    add_index :orders, :status
  end
end
