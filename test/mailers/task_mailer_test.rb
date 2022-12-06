require "test_helper"

class TaskMailerTest < ActionMailer::TestCase
  test "task_notification" do
    mail = TaskMailer.task_notification
    assert_equal "Task notification", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
