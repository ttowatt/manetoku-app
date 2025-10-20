class RemoveColumnsInTables < ActiveRecord::Migration[6.1]
  def change
    remove_column :likes, :user_id, :integer
    remove_column :likes, :post_id, :integer
    remove_column :likes, :comment_id, :integer

    remove_column :posts, :user_id, :integer

    remove_column :reviews, :user_id, :integer
    remove_column :reviews, :post_id, :integer

    remove_column :notifications, :user_id, :integer
    remove_column :notifications, :post_id, :integer

    remove_column :comments, :user_id, :integer
    remove_column :comments, :post_id, :integer

  end
end
