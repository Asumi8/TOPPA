# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  before_action :ensure_normal_user, only: :destroy

  def ensure_normal_user
    if resource.email == 'guest@example.com'
      redirect_to user_path(current_user), alert: 'ゲストユーザーは削除できません。'
    end
  end

  protected

  def update_resource(resource, params)
    resource.update_without_password(params)
  end

end
