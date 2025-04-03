class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :name, null: false
      t.datetime :expires_at, null: false
      t.string :status, default: "active", null: false
      t.references :parent_task, null: true, default: nil, foreign_key: { to_table: :tasks }
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tasks, :expires_at
  end
end
