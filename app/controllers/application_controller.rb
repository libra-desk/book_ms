class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  # This basically cross checks the token to verify that it is a genuine request
  def authenticate_request
    token = request.headers["Authorization"]
    decoded_value = JsonWebToken.decode(token)
    @current_user = decoded_value ? decoded_value : nil

    unless @current_user
      render json: { error: "Unauthorized request" }
    end
  end

  def current_user
    @current_user
  end
end
