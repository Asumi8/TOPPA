class Comment < ApplicationRecord
  validates :content, presence: true, length: { maximum: 100 }

  belongs_to :task
  belongs_to :user
end
