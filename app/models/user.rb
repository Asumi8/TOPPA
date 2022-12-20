class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, validate_on_invite: true

  validates :name, presence: true, length: { maximum: 30 }, unless: :invited_to_sign_up?
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

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
