class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product
  
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
  validates :price_at_order, numericality: { greater_than_or_equal_to: 0 }
  validates :product_id, uniqueness: { scope: :order_id }
  
  before_create :set_price_from_product
  after_create :update_pending_purchase_count
  after_destroy :decrease_pending_purchase_count
  
  private
  
  def set_price_from_product
    self.price_at_order ||= product.price
  end
  
  def update_pending_purchase_count
    if order.status == 'pending'
      product.update(pending_purchase_count: product.pending_purchase_count + quantity)
    end
  end
  
  def decrease_pending_purchase_count
    if order.status == 'pending'
      product.update(pending_purchase_count: [product.pending_purchase_count - quantity, 0].max)
    end
  end
end
