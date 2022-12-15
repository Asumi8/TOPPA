class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :prohibit_access_by_others, only: %i[show]

  def show
    @user = User.find(params[:id])
  end

  def invitation
  end

  def user_params
    params.require(:user).permit(:name, :email, :icon, :icon_cache)
  end

  private

  def prohibit_access_by_others
    if current_user.id != params[:id].to_i
      flash[:notice] = "アクセス権限がありません"
      redirect_to user_path(current_user)
    end
  end
end
