class Addtaskbreak < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :break, :boolean, default: false

  end
end
