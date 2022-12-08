class AddColmunToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :invited_by_team_id, :integer
  end
end
