class Api::V1::MerchantsController < ApplicationController
  def show
    merchant = Merchant.find(params[:id])
    render json: {
      total_return_amount: merchant.sum_of_returned_amounts,
      average_return_window: merchant.average_return_window
    }
  end
end
