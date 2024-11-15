class Api::V1::CustomerReturnsController < ApplicationController
  before_action :set_customer_return, only: [:update, :refund]

  def index
    customer_returns = CustomerReturn.order(:id).includes(:items).all
    render json: customer_returns.to_json(include: :items)
  end

  # retrieving data

  def update
    if @customer_return.update(customer_return_params)
      render json: @customer_return.to_json(include: :items)
    else
      render json: { errors: @customer_return.errors.full_messages }, status: :unprocessable_entity
    end
  end
  # updating data

  def refund
    if @customer_return.update(status: 'refunded')
      render json: { message: 'Refund successful' }, status: :ok 
    else
      render json: { errors: @customer_return.errors.full_messages }, status: :unprocessable_entity
    end
  end
# creating new customer return object

  def set_customer_return
    @customer_return = CustomerReturn.find(params[:id])
  end

  def customer_return_params
    params.require(:customer_return).permit(:order_date, :registered_date, :status, :merchant_id)
  end
end
