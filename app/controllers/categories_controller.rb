class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.team_id = params[:team_id]
    if @category.save
      redirect_to new_team_task_path
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(:name, :team_id)
  end

end
