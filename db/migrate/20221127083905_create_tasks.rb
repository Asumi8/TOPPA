class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :category
      t.string :name
      t.date :expired_at
      t.text :remarks
      t.string :image
      t.boolean :status
      t.boolean :repeat
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
