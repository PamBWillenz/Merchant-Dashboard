# spec/models/merchant_spec.rb
require 'rails_helper'

RSpec.describe Merchant, type: :model do
  it { should have_many(:customer_returns) }
  it { should have_many(:items).through(:customer_returns) }

  describe '#sum_of_returned_amounts' do
    it 'calculates the total return amounts' do
      merchant = create(:merchant)
      customer_return = create(:customer_return, merchant: merchant)
      create(:item, customer_return: customer_return, price: 10.0)
      create(:item, customer_return: customer_return, price: 20.0)

      expect(merchant.sum_of_returned_amounts).to eq(30.0)
    end
  end

  describe '#average_return_window' do
    it 'calculates the average return window' do
      merchant = create(:merchant)
      create(:customer_return, merchant: merchant, order_date: 10.days.ago, registered_date: 5.days.ago)
      create(:customer_return, merchant: merchant, order_date: 20.days.ago, registered_date: 10.days.ago)

      expect(merchant.average_return_window).to eq(7.5)
    end
  end
end