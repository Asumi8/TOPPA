class TasksController < ApplicationController
  before_action :set_task, only: %i[show edit update destroy]
  before_action :authenticate_user!

  def index

    @tasks = Team.find(params[:team_id]).tasks

    @tasks = @tasks.created_order if params[:sort_status].present?
    @tasks = @tasks.expired_order if params[:sort_expired].present?
    @tasks = @tasks.created_order if params[:sort_created].present?
    @tasks = @tasks.page(params[:page]).per(5)

    @date = Date.current()
  end

  def show
    @comments = @task.comments
    @comment = @task.comments.build
  end

  def new
    @task = Task.new
    @categories = Team.find(params[:team_id]).categories
  end

  def edit
    @categories = Team.find(params[:team_id]).categories
  end


  def create
    @team = Team.find(params[:team_id])
    @task = current_user.tasks.build(task_params)
    @task.team_id = params[:task][:team_id]
    @categories = Team.find(params[:task][:team_id]).categories
    if @task.valid?
      @task.save
      redirect_to team_tasks_path(params[:task][:team_id])
    else
      render :new
    end
  end

  def update
    @categories = Team.find(params[:task][:team_id]).categories
    @task.user_id = current_user.id
    if @task.update(task_params)
      redirect_to team_tasks_path(params[:task][:team_id])
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to team_tasks_path(@task.team_id)
  end

  private

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:category_id, :name, :expired_at, :remarks, :image, :image_cache, :status, :repeat, :user_id, :team_id)
    end
end
