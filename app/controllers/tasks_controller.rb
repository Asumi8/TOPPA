class TasksController < ApplicationController
  before_action :set_task, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  # GET /tasks or /tasks.json
  def index
    @tasks = Team.find(params[:team_id]).tasks

    @tasks = @tasks.created_order if params[:sort_status].present?
    @tasks = @tasks.expired_order if params[:sort_expired].present?
    @tasks = @tasks.created_order if params[:sort_created].present?

    @date = Date.current()
  end

  # GET /tasks/1 or /tasks/1.json
  def show
    @comments = @task.comments
    @comment = @task.comments.build
  end

  # GET /tasks/new
  def new
    @task = Task.new
    @categories = Team.find(params[:team_id]).categories
  end

  # GET /tasks/1/edit
  def edit
    @categories = Team.find(params[:team_id]).categories
  end

  # POST /tasks or /tasks.json
  def create
    # @task = Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    @task.team_id = params[:task][:team_id]

    if @task.save
      redirect_to team_tasks_path(params[:task][:team_id])
    else
      render :new
    end

    # respond_to do |format|
    #   if @task.save
    #     format.html { redirect_to task_url(@task), notice: "Task was successfully created." }
    #     format.json { render :show, status: :created, location: @task }
    #   else
    #     format.html { render :new, status: :unprocessable_entity }
    #     format.json { render json: @task.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /tasks/1 or /tasks/1.json
  def update
    if @task.update(task_params)
      redirect_to team_tasks_path(params[:task][:team_id])
    else
      render :edit
    end
    # respond_to do |format|
    #   if @task.update(task_params)
    #     format.html { redirect_to task_url(@task), notice: "Task was successfully updated." }
    #     format.json { render :show, status: :ok, location: @task }
    #   else
    #     format.html { render :edit, status: :unprocessable_entity }
    #     format.json { render json: @task.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # DELETE /tasks/1 or /tasks/1.json
  def destroy
    @task.destroy
    redirect_to team_tasks_path(@task.team_id)
    # @task.destroy

    # respond_to do |format|
    #   format.html { redirect_to tasks_url, notice: "Task was successfully destroyed." }
    #   format.json { head :no_content }
    # end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_task
      @task = Task.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def task_params
      params.require(:task).permit(:category_id, :name, :expired_at, :remarks, :image, :image_cache, :status, :repeat, :user_id, :team_id)
    end
end
