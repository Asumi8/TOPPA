class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    teams_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name]) # team_idの削除
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name icon]) # team_idの削除
    devise_parameter_sanitizer.permit(:invite, keys: %i[email]) # team_id, nameの削除
    devise_parameter_sanitizer.permit(:accept_invitation, keys: %i[password password_confirmation invitation_token name]) # team_idの削除
  end
end
