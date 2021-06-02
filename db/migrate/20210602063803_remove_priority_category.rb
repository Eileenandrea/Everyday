class RemovePriorityCategory < ActiveRecord::Migration[6.1]
  def change
    remove_column :categories, :priority, :string
  end
end
