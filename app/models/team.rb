class Team < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30}
  validates :reward, length: { maximum: 300 }

  belongs_to :user
  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns, source: :user
  has_many :tasks
end
