class AddIndexesToTables < ActiveRecord::Migration[6.1]
  def change
    add_index :users, :username, unique: true

    add_index :categories, :user_id

    add_index :posts, :user_id

    add_index :comments, :user_id
    add_index :comments, :post_id

    add_index :reviews, :user_id
    add_index :reviews, :post_id

    add_index :likes, :user_id
    add_index :likes, :post_id
    add_index :likes, :comment_id

    add_index :notifications, :post_id

  end
end
