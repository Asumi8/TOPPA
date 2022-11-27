class Task < ApplicationRecord
  belongs_to :user
  belongs_to :team

  scope :status_order, -> { order(status: :ASC) }
  scope :expired_order, -> { order(expired_at: :ASC) }
  scope :created_order, -> { order(created_at: :DESC) }

end
