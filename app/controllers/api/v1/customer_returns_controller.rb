class Api::V1::CustomerReturnsController < ApplicationController
  def index
    customer_returns = CustomerReturn.includes(:items).all
    render json: customer_returns.to_json(include: :items)
  end

  def update
    customer_return = CustomerReturn.find(params[:id])
    if customer_return.update(customer_return_params)
      render json: customer_return.to_json(include: :items)
    else
      render json: { errors: customer_return.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def customer_return_params
    params.require(:customer_return).permit(:order_date, :registered_date, :status, :merchant_id)
  end
end
