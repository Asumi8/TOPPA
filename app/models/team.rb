class Team < ApplicationRecord
  belongs_to :user
  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns, source: :user
  has_many :tasks
end
