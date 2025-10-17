class RemoveUserIdFromNotifications < ActiveRecord::Migration[6.1]
  def change
    remove_column :notifications, :user_id, :integer
  end
end
