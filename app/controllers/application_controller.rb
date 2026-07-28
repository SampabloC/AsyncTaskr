class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def current_user
    return @current_user if instance_variable_defined?(:@current_user)

    payload = auth_payload
    return nil unless payload

    @current_user = User.find_by(id: payload["user_id"])
  end

  def authenticate_user!
    render json: {
      error: {
       code: "UNAUTHORIZED",
       message: "Invalid or missing token"
      }
    }, status: :unauthorized unless current_user
  end

  private

  def auth_payload
    token = auth_token
    return nil unless token

    JsonWebToken.decode(token)
  end

  def auth_token
    header = request.headers["Authorization"]
    return nil unless header.present?

    scheme, token = header.split(" ")

    token if scheme == "Bearer"
  end
end
