class TaskMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.task_mailer.task_notification.subject
  #
  def task_notification(team)
    @today = Date.current
    @team = team
    team.tasks.each do |task|
      if task.status == false && (task.expired_at - @today).to_i < 14
        @near_deadline_task = true
      end
    end
    if @near_deadline_task == true
      team_users = []
      team_users << team.user
      team_users << team.users
      @flatten_team_users = team_users.flatten
      mail to: @flatten_team_users.pluck(:email), subject: "期限が近づいたタスクのお知らせ"
    end
  end
end
