class TeamsController < ApplicationController
  before_action :set_team, only: %i[show edit update destroy mvp mvp_delete assign_delete]
  before_action :authenticate_user!
  before_action :prohibit_access_by_other_teams, except: %i[index new create]

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
      @assign = Assign.new
      @assign.user_id = current_user.id
      @assign.team_id = @team.id
      @assign.save
      redirect_to teams_path(current_user), notice: "チームを作成しました！"
    else
      render 'new'
    end
  end

  def update
    if @team.update(team_params)
      redirect_to teams_path(params[:team_id]), notice: 'チームを編集しました！'
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to teams_path(params[:team_id]), notice: 'チームを削除しました。'
  end

  def assign_delete
    assign_delete = @team.assigns.where(user_id: current_user.id)
    assign_delete[0].destroy
    redirect_to teams_path(params[:team_id])
  end

  def mvp
    completed_users = @team.tasks.where(status: true).pluck(:user_id)
    @completed_count = completed_users.group_by(&:itself).map { |key, value| [User.find(key).name, value.count] }.to_h
    max_value = @completed_count.values.max
    bests = @completed_count.select{|k,v| v == max_value}
    @maximum_completed_user = bests.keys
  end

  def mvp_delete
    completed_not_repeat_task = @team.tasks.where(status: true).where(repeat: false)
    if completed_not_repeat_task.present?
      completed_not_repeat_task.destroy_all
      redirect_to team_tasks_path(params[:id]), notice: '実行済みのタスクを削除しました'
    else
      redirect_to team_tasks_path(params[:id]), notice: '削除できるタスクがありません'
    end
  end

  private

  def set_team
    @team = Team.find(params[:id])
  end

  def team_params
    params.require(:team).permit(:name, :reward, :period, :user_id, :owner_id)
  end

  def prohibit_access_by_other_teams
    unless current_user.assigns.pluck(:team_id).any?(params[:id].to_i)
      flash[:notice] = "アクセス権限がありません"
      redirect_to teams_path
    end
  end
end
