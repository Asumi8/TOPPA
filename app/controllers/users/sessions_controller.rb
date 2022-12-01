# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to user_path(current_user), notice: 'ゲストユーザーとしてログインしました。'
  end

  def admin_sign_in
    user = User.admin
    sign_in user
    redirect_to user_path(current_user), notice: 'ゲスト管理者ユーザーとしてログインしました。'
  end
end
