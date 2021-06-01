class TaskStatusCompletedAt < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :completed, :boolean
    add_column :tasks, :completed_at, :datetime

  end
end
