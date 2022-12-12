module TasksHelper
  def choose_new_or_edit
    if action_name == 'new'
      team_tasks_path
    elsif action_name == 'edit'
      task_path(team_id: params[:team_id])
    end
  end
end
