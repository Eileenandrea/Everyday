class AddUserId < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :user_id, :int
  end
end
