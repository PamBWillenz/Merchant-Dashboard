class Api::V1::CustomerReturnsController < ApplicationController
  before_action :set_customer_return, only: [:update, :refund]
  before_action :authorized

  def index
    customer_returns = CustomerReturn.order(:id).includes(:items).all
    render json: customer_returns.to_json(include: :items)
  end

  def update
    if @customer_return.update(customer_return_params)
      render json: @customer_return.to_json(include: :items)
    else
      render json: { errors: @customer_return.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def refund
    if @customer_return.update(status: 'refunded')
      render json: { message: 'Refund successful' }, status: :ok 
    else
      render json: { errors: @customer_return.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_customer_return
    @customer_return = CustomerReturn.find(params[:id])
  end

  def customer_return_params
    params.require(:customer_return).permit(:order_date, :registered_date, :status, :merchant_id)
  end

  def authorized
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      @merchant_user = Merchant.find(decoded[0]['merchant_id'])
    rescue JWT::DecodeError
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end
