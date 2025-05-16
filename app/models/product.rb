class Product < ApplicationRecord
  validates :name, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates :purchase_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :pending_purchase_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :stock_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
