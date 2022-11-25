class AddUserRefToTeams < ActiveRecord::Migration[6.1]
  def change
    add_reference :teams, :owner, foreign_key: { to_table: :users }
    add_reference :teams, :user, foreign_key: true
  end
end
