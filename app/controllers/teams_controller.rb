class TeamsController < ApplicationController
  before_action :set_team, only: %i[ show edit update destroy ]
  before_action :authenticate_user! #ログイン済のユーザーのみアクセスできる

  # GET /teams or /teams.json
  def index
    @teams = current_user.team_members
  end

  # GET /teams/1 or /teams/1.json
  def show
  end

  # GET /teams/new
  def new
    @team = Team.new
  end

  # GET /teams/1/edit
  def edit
  end

  # POST /teams or /teams.json
  def create
    current_user.team_members.build(team_params) #変更
    if current_user.save #変更
      redirect_to team_path(current_user), notice: "作成しました"
    else
      render 'new'
    end
  end

  # PATCH/PUT /teams/1 or /teams/1.json
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

  # DELETE /teams/1 or /teams/1.json
  def destroy
    @team.destroy

    respond_to do |format|
      format.html { redirect_to teams_url, notice: "Team was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def team_params
      params.require(:team).permit(:name, :reward, :period, :user_id, :owner_id)
    end
end
