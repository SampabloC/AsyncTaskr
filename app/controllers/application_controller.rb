class ApplicationController < ActionController::API
  before_action :authenticate_user!

  def current_user
    return @current_user if defined?(@current_user)

    token = request.headers["Authorization"]&.split(" ")&.last
    return nil unless token

    user_id = decode_token(token)
    @current_user = User.find_by(id: user_id)
  end

  def authenticate_user!
    render json: { error: "Unauthorized" }, status: :unauthorized unless current_user
  end

  private

  def decode_token(token)
    begin
      decoded = JWT.decode(token, Rails.application.secret_key_base)[0]
      decoded["user_id"]
    rescue JWT::DecodeError
      nil
    end
  end
end
