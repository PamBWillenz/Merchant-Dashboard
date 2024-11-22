require 'rails_helper'

RSpec.describe "Api::V1::Auth", type: :request do
  let(:merchant) { create(:merchant, email: 'test@example.com', password: 'password') }
  let(:token) do
    post '/api/v1/login', params: { email: merchant.email, password: merchant.password }
    JSON.parse(response.body)['token']
  end

  describe "GET /index" do
    it 'returns a success response' do
      token # Ensure the token is generated before the request
      get '/api/v1/auth', headers: { 'Authorization' => "Bearer #{token}" }
      expect(response).to be_successful
      expect(response.content_type).to eq('application/json; charset=utf-8')
    end
  end
end
