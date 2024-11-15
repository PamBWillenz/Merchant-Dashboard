class Api::V1::MerchantsController < ApplicationController
  def index
    merchants = Merchant.all
    render json: merchants
  end

  
  def show
    merchant = Merchant.find(params[:id])
    render json: merchant
  end

  private

  def merchants_params
    params.require(:merchants).permit(:name)
  end
end
