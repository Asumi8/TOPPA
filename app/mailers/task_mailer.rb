class TaskMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.task_mailer.task_notification.subject
  #
  def task_notification
    @greeting = "Hi"

    mail to: "hogehoge@example.com"
  end
end
