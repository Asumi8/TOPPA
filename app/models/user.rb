class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable

  has_many :assigns, dependent: :destroy
  has_many :team_members, through: :assigns, source: :team
  has_many :teams #ついか
  has_many :tasks

  attr_accessor :team_id
end
