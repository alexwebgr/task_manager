class ChangeStatusColumnType < ActiveRecord::Migration[8.0]
  def up
    change_column :tasks, :status, :integer, default: 0, null: false
  end

  def down
    change_column :tasks, :status, :string, default: "active", null: false
  end
end
