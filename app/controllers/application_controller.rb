class ApplicationController < ActionController::API
  before_action :authorized

  # helper method takes a payload (user info) and encodes a JWT token
  def encode_token(payload)
    JWT.encode(payload, Rails.application.secrets.secret_key_base)
  end

  # helper method to extract token from authorization header
  def auth_header
    request.headers['Authorization']
  end

  # decodes it using the same secret key, and retrieves the user ID from the decoded token.
  def decoded_token
    if auth_header
      token = auth_header.split(' ')[1]
      begin
        JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
      rescue JWT::DecodeError
        nil
      end
    end
  end

  # Find the merchant user by decoding the token and finding the merchant ID.
  # The @current_merchant instance variable is used to cache the merchant object, preventing multiple database queries for the same request.
  # If the token is invalid or missing, it returns nil.
  def current_merchant
    if decoded_token
      merchant_id = decoded_token[0]['merchant_id']
      @current_merchant ||= Merchant.find_by(id: merchant_id)
    end
  end

  def logged_in?
    !!current_merchant # Returns true if current_user is not nil, otherwise false
    # !! converts the value to a boolean
  end

  def authorized
    render json: { error: 'Please log in' }, status: :unauthorized unless logged_in?
  end
end
