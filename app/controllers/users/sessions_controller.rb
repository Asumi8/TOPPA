# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to teams_path, notice: 'ゲストユーザーとしてログインしました。'
  end

  def admin_sign_in
    user = User.admin
    sign_in user
    redirect_to teams_path, notice: 'ゲスト管理者ユーザーとしてログインしました。'
  end
end
