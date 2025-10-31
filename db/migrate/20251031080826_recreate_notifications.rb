class RecreateNotifications < ActiveRecord::Migration[6.1]
  def change
    drop_table :notifications, if_exists: true

    create_table :notifications do |t|
      t.references :user, null: false, foreign_key: true
      t.references :notifiable, polymorphic: true, null: false
      t.boolean :read, default: false, null: false 
      t.timestamps
    end
  end
end
