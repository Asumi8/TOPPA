class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.integer :category_id, null: false, foreign_key: true
      t.string :name, null: false
      t.date :expired_at, null: false
      t.text :remarks
      t.string :image
      t.boolean :status, null: false, default: false
      t.boolean :repeat
      t.references :user, null: false, foreign_key: true
      t.references :team, null: false, foreign_key: true

      t.timestamps
    end
  end
end
