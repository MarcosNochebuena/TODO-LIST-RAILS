class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!, unless: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password])
  end

  private

  def authenticate_user!
    authenticate_with_http_token do |token, options|
      begin
        jwt_payload = JWT.decode(token, "secret").first
        @current_user_id = jwt_payload["sub"]
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        render json: { error: 'Invalid or expired token' }, status: :unauthorized
      end
    end || render_unauthorized
  end

  def current_user
    @current_user ||= User.find_by(id: @current_user_id) if @current_user_id
  end

  def render_unauthorized
    render json: { error: 'This action requires authentication' }, status: :unauthorized
  end
end
