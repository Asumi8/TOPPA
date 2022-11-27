json.extract! task, :id, :category, :name, :expired_at, :remarks, :image, :status, :repeat, :user_id, :team_id, :created_at, :updated_at
json.url task_url(task, format: :json)
