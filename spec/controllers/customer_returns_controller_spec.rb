require 'rails_helper'

RSpec.describe Api::V1::CustomerReturnsController, type: :controller do
  render_views

  let(:user) { create(:user) }
  let(:token) { JWT.encode({ user_id: user.id }, Rails.application.secrets.secret_key_base) }
  let(:valid_headers) { { 'Authorization' => "Bearer #{token}" } }

  describe 'GET #index' do
    it 'returns a success response' do
      request.headers.merge!(valid_headers)
      get :index
      puts response.body # Add this line to print the response body
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end

  describe 'PUT #update' do
    it 'updates the customer return status' do
      customer_return = create(:customer_return, status: 'pending')
      request.headers.merge!(valid_headers)
      put :update, params: { id: customer_return.id, customer_return: { status: 'approved' } }
      customer_return.reload
      expect(customer_return.status).to eq('approved')
    end
  end

  describe 'POST #refund' do
    it 'refunds the customer return' do
      customer_return = create(:customer_return, status: 'approved')
      request.headers.merge!(valid_headers)
      post :refund, params: { id: customer_return.id }
      customer_return.reload
      expect(customer_return.status).to eq('refunded')
    end
  end
end