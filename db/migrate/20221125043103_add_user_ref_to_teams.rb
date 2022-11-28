class AddUserRefToTeams < ActiveRecord::Migration[6.1]
  def change
    add_reference :teams, :user, foreign_key: true
  end
end
