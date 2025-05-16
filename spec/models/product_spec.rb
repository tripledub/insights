require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:purchase_count).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:pending_purchase_count).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:stock_count).only_integer.is_greater_than_or_equal_to(0) }
  end
end
