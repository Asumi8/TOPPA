class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def user_params #今後追加する
    params.require(:user).permit(:name, :email, :icon)
  end
end
