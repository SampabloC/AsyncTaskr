class AuthController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :login ]

  def login
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: {
        data: { token: token }
      }
    else
      render json: {
        error: { message: "Invalid credentials" }
      }, status: :unauthorized
    end
  end
end
