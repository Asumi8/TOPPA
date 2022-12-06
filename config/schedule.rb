require File.expand_path(File.dirname(__FILE__) + '/environment')
set :path_env, ENV['PATH']
#job_type :runner, "cd :path && PATH=':path_env' bin/rails runner -e :environment ':task' :output"
job_type :rake, "cd :path && PATH=':path_env' :environment_variable=:environment bundle exec rake :task --silent :output"
rails_env = ENV['RAILS_ENV'] || :development
set :output, "#{Rails.root}/log/cron.log"
set :environment, rails_env

every :sunday, at: '9:00 am' do # Many shortcuts available: :hour, :day, :month, :year, :reboot
  rake 'deadline_approaching:notification'
end