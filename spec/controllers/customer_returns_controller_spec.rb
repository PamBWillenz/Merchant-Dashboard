require 'rails_helper'

RSpec.describe Api::V1::CustomerReturnsController, type: :controller do
  render_views
  describe 'GET #index' do
    it 'returns a success response' do
      get :index
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'PUT #update' do
    it 'updates the customer return status' do
      customer_return = create(:customer_return, status: 'pending')
      put :update, params: { id: customer_return.id, customer_return: { status: 'approved' } }
      customer_return.reload
      expect(customer_return.status).to eq('approved')
    end
  end

  describe 'POST #refund' do
    it 'refunds the customer return' do
      customer_return = create(:customer_return, status: 'approved')
      post :refund, params: { id: customer_return.id }
      customer_return.reload
      expect(customer_return.status).to eq('refunded')
    end
  end
end