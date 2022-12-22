class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, validate_on_invite: true

  #validates :name, presence: true, length: { maximum: 30 }, unless: :valid_invitation?
  # with_options unless: -> {  :valid_invitation? }  do
  #   validates :name, presence: true, length: { maximum: 30 }
  # end
  #validates :name, presence: true, length: { maximum: 30 }, if: :accepting_invitation?
  #validates :name, presence: true, length: { maximum: 30 }, unless: :invited_to_sign_up?
  validates :name, presence: true, length: { maximum: 30 }, unless: -> { invited_by_team_id.present? }
  #validates :name, presence: true, length: { maximum: 30 }, unless: :invitation_taken?
  validates :email, presence: true, length: { maximum: 255 }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_many :assigns, dependent: :destroy
  has_many :team_members, through: :assigns, source: :team
  has_many :teams, dependent: :destroy
  has_many :tasks, dependent: :destroy
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
