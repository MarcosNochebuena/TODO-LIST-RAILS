# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Logged in successfully' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes],
        token: request.env['warden-jwt_auth.token']
      }, status: :ok
    else
      render json: {
        status: { code: 401, message: 'Invalid email or password' }
      }, status: :unauthorized
    end
  end

  def respond_to_on_destroy
    head :no_content
  end
end
