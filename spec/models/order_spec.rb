require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'associations' do
    it { should have_many(:order_products).dependent(:destroy) }
    it { should have_many(:products).through(:order_products) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_inclusion_of(:status).in_array([ 'pending', 'completed' ]) }
    it { should validate_numericality_of(:total_amount).is_greater_than_or_equal_to(0) }
  end

  describe 'scopes' do
    it '.pending returns only pending orders' do
      pending_order = Order.create(status: 'pending')
      completed_order = Order.create(status: 'completed')

      expect(Order.pending).to include(pending_order)
      expect(Order.pending).not_to include(completed_order)
    end

    it '.completed returns only completed orders' do
      pending_order = Order.create(status: 'pending')
      completed_order = Order.create(status: 'completed')

      expect(Order.completed).to include(completed_order)
      expect(Order.completed).not_to include(pending_order)
    end
  end
end
