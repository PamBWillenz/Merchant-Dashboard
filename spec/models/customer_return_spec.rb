require 'rails_helper'

RSpec.describe CustomerReturn, type: :model do
  it { should belong_to(:merchant) }
  it { should have_many(:items) }

  it { should validate_inclusion_of(:status).in_array(%w[pending approved rejected refunded]) }

  describe 'validations' do
    it 'validates that the return window is within 14 days' do
      customer_return = build(:customer_return, order_date: 20.days.ago, registered_date: 5.days.ago)
      expect(customer_return).to_not be_valid
      expect(customer_return.errors[:registered_date]).to include('must be within 14 days of the order date')
    end
  end
end