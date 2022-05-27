class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  before_action :authenticate_user!, unless: :api_path

  before_action :update_allowed_parameters, if: :devise_controller?

  def api_path
    request.original_url.include?('api')
  end

  protected

  def update_allowed_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :photo, :bio, :email, :password) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :photo, :bio, :email, :password, :current_password)
    end
  end
end
