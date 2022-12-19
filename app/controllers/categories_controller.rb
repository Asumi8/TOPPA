class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :prohibit_access_by_other_teams, only: %i[new]

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.team_id = params[:team_id]
    if @category.save
      redirect_to new_team_task_path
    else
      flash[:notice] = "登録できませんでした。"
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :team_id)
  end

  def prohibit_access_by_other_teams
    unless current_user.assigns.pluck(:team_id).any?(params[:team_id].to_i)
      flash[:notice] = "アクセス権限がありません"
      redirect_to teams_path
    end
  end

end
