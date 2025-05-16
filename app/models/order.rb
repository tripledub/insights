class Order < ApplicationRecord
  has_many :order_products, dependent: :destroy
  has_many :products, through: :order_products
  
  validates :status, presence: true, inclusion: { in: ['pending', 'completed'] }
  validates :total_amount, numericality: { greater_than_or_equal_to: 0 }
  
  scope :pending, -> { where(status: 'pending') }
  scope :completed, -> { where(status: 'completed') }
  
  def complete!
    transaction do
      self.status = 'completed'
      
      # Update product counts
      order_products.each do |order_product|
        product = order_product.product
        product.pending_purchase_count -= order_product.quantity
        product.purchase_count += order_product.quantity
        product.stock_count -= order_product.quantity
        product.save!
      end
      
      save!
    end
  end
end
