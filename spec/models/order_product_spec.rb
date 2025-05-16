require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  describe 'associations' do
    it { should belong_to(:order) }
    it { should belong_to(:product) }
  end

  describe 'validations' do
    it { should validate_numericality_of(:quantity).only_integer.is_greater_than(0) }
    it { should validate_numericality_of(:price_at_order).is_greater_than_or_equal_to(0) }
  end
end
