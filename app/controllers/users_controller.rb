class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    @user = User.find(params[:id])
  end

  def invitation
  end

  def user_params
    params.require(:user).permit(:name, :email, :icon, :icon_cache)
  end
end
