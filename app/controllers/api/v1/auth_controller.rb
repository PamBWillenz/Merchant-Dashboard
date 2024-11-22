class Api::V1::AuthController < ApplicationController
  before_action :authorized, only: [:index]

  def login
    merchant = Merchant.find_by(email: params[:email])
    if merchant&.authenticate(params[:password])
      token = encode_token({ merchant_id: merchant.id })
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def index
    render json: { message: 'Success' }, status: :ok
  end

  private

  # helper method takes a payload (user info) and encodes a JWT token
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  # helper method to extract token from authorization header
  # decodes it using the same secret key, and retrieves the user ID from the decoded token. 
  # If the token is valid, it sets the @current_user instance variable to the corresponding user. 
  # If the token is invalid or missing, it responds with a JSON error message and an HTTP status code of 401 Unauthorized.
  def authorized
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      @current_merchant = Merchant.find(decoded[0]['merchant_id'])
    rescue JWT::DecodeError
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end
