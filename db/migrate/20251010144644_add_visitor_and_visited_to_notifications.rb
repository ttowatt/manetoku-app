class AddVisitorAndVisitedToNotifications < ActiveRecord::Migration[6.1]
  def change
    add_column :notifications, :visitor_id, :integer, null: false
    add_column :notifications, :visited_id, :integer, null: false

    add_index :notifications, :visitor_id
    add_index :notifications, :visited_id
  end
end
