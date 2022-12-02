class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @teams = Team.all
  end

  def show
    has_completed_tasks = @team.tasks.where(status: true).pluck(:user_id)
    @completed_tasks_count = has_completed_tasks.group_by(&:itself).map { |key, value| [User.find(key).name, value.count] }.to_h
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
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to team_url(@team), notice: "Team was successfully updated." }
        format.json { render :show, status: :ok, location: @team }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_team
      @team = Team.find(params[:id])
    end

    def team_params
      params.require(:team).permit(:name, :reward, :period, :user_id, :owner_id)
    end
end
