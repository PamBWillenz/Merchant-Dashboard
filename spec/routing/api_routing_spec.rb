# spec/routing/api_routing_spec.rb
require 'rails_helper'

RSpec.describe 'API Routing', type: :routing do
  it 'routes to customer_returns#index' do
    expect(get: '/api/v1/customer_returns').to route_to('api/v1/customer_returns#index')
  end

  it 'routes to customer_returns#update' do
    expect(put: '/api/v1/customer_returns/1').to route_to('api/v1/customer_returns#update', id: '1')
  end

  it 'routes to customer_returns#refund' do
    expect(post: '/api/v1/customer_returns/1/refund').to route_to('api/v1/customer_returns#refund', id: '1')
  end
end