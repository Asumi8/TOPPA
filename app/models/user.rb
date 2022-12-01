class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :assigns, dependent: :destroy
  has_many :team_members, through: :assigns, source: :team
  has_many :teams
  has_many :tasks
  has_many :comments, dependent: :destroy

  mount_uploader :icon, ImageUploader

  attr_accessor :team_id

  def self.guest
    find_or_create_by!(email: 'guest@example.com')
  end

  def self.admin
    find_or_create_by!(email: 'admin@example.com')
  end
end
