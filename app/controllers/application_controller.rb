class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :team_id])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :team_id])
    devise_parameter_sanitizer.permit(:invite) { |u| u.permit(:email, :name, :team_id) }
    devise_parameter_sanitizer.permit(:accept_invitation) { |u| u.permit(:password, :password_confirmation, :invitation_token, :name, :team_id) }
  end
end
