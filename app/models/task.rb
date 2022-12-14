class Task < ApplicationRecord
  validates :category_id, presence: true
  validates :name, presence: true, length: { maximum: 30 }
  validates :expired_at, presence: true
  validates :remarks, length: { maximum: 300 }

  mount_uploader :image, ImageUploader

  has_many :comments, dependent: :destroy

  belongs_to :user
  belongs_to :team
  belongs_to :category

  scope :status_choice, -> { where(status: false) }
  scope :status_order, -> { order(status: :ASC) }
  scope :expired_order, -> { order(expired_at: :ASC) }
  scope :created_order, -> { order(created_at: :ASC) }

end
