class CommentsController < ApplicationController
  def create
    @task = Task.find(params[:task_id])
    @comment = @task.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to task_path(@task), notice: '投稿できませんでした...' }
      end
    end
  end

  def destroy
    @comment = Comment.find(params[:comment_id])
    @comment.destroy
    respond_to do |format|
      flash.now[:notice] = 'コメントが削除されました'
      format.js { render :index }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :task_id, :user_id)
  end
end
