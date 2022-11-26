class Team < ApplicationRecord
  has_many :assigns, dependent: :destroy
  has_many :users, through: :assigns, source: :user
  
  # いれるとうまくいかない　belongs_to :user
end
