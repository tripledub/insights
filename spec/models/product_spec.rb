require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'associations' do
    it { should have_many(:order_products).dependent(:destroy) }
    it { should have_many(:orders).through(:order_products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:purchase_count).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:pending_purchase_count).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:stock_count).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#available_stock' do
    it 'returns stock_count minus pending_purchase_count' do
      product = Product.new(stock_count: 10, pending_purchase_count: 3)
      expect(product.available_stock).to eq(7)
    end
  end
end
