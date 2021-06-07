class AddPomodoroTimeAndPriority < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :priority, :int, default: 2
    add_column :tasks, :est_pomodoro, :int, default: 0
    add_column :tasks, :actual_pomodoro, :int, default: 0
  end
end
