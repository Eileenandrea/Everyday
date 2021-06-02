class AddPriority < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :priority, :string

  end
end
