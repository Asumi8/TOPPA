class Category < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }

  has_many :tasks

  belongs_to :team
end
