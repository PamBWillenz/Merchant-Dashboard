class Api::V1::AuthController < ApplicationController
  before_action :authorized, only: [:index]

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  def index
    render json: { message: 'Success' }, status: :ok
  end

  private

  def encode_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  def authorized
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      @current_user = User.find(decoded[0]['user_id'])
    rescue JWT::DecodeError
      render json: { error: 'Not Authorized' }, status: :unauthorized
    end
  end
end
