namespace :deadline_approaching do
  desc '【TOPPA】期限が近いタスクについてのお知らせ'
  task notification: :environment do
    Team.all.each do |team|
      if team.tasks.present?
        TaskMailer.task_notification(team).deliver_now
      end
    end
    puts "成功!"
  end
end
