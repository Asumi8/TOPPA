class TeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destroy mvp mvp_delete]
  before_action :authenticate_user!

  def index
    @teams = Team.all
  end

  def show
    completed_users = @team.tasks.where(status: true).pluck(:user_id)
    @completed_count = completed_users.group_by(&:itself).map { |key, value| [User.find(key).name, value.count] }.to_h
  end

  def new
    @team = Team.new
  end

  def edit
  end

  def create
    @team = current_user.teams.build(team_params)

    if @team.save
      redirect_to teams_path(current_user), notice: "チームを作成しました！"
    else
      render 'new'
    end
  end

  def update
    if @team.update(team_params)
      redirect_to teams_path(params[:team_id])
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_path(params[:team_id])
  end

  def mvp
    completed_users = @team.tasks.where(status: true).pluck(:user_id)
    completed_count = completed_users.group_by(&:itself).map { |key, value| [User.find(key).name, value.count] }.to_h
    max_value = completed_count.values.max
    bests = completed_count.select{|k,v| v == max_value}
    @maximum_completed_user = bests.keys
  end

  def mvp_delete
    @team.tasks.where(status: true).where(repeat: false).destroy_all
    redirect_to team_tasks_path(params[:id]), notice: '実行済みのタスクを削除しました'
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :reward, :period, :user_id, :owner_id)
  end
end
