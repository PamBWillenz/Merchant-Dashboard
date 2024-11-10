class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: merchants
  end

  
  def show
    merchant = Merchant.find(params[:id])
    render json: {
      total_return_amount: merchant.sum_of_returned_amounts,
      average_return_window: merchant.average_return_window
    }
  end

  private

  def merchants_params
    params.require(:merchants).permit(:name)
  end
end
