class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def current_user
    return @current_user if defined?(@current_user)

    payload = auth_payload
    return nil unless payload

    @current_user = User.find_by(id: payload["user_id"])
  end

  def authenticate_user!
    render json: { error: "Unauthorized" }, status: :unauthorized unless current_user
  end

  private

  def auth_payload
    token = auth_token
    return nil unless token

    JsonWebToken.decode(token)
  end

  def auth_token
    request.headers["Authorization"]&.split(" ")&.last
  end
end
