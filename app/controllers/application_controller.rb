class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    teams_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name team_id])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name team_id icon])
    devise_parameter_sanitizer.permit(:invite, keys: %i[team_ids:[] email name team_id])
    # { |u| u.permit(:email, :name, :team_id) }
    devise_parameter_sanitizer.permit(:accept_invitation) { |u| u.permit(:password, :password_confirmation, :invitation_token, :name, :team_id) }
  end
end
