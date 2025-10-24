class AddColumnsInTables < ActiveRecord::Migration[6.1]
  def change
    add_reference :likes, :user, foreign_key: true
    add_reference :likes, :post, foreign_key: true
    add_reference :likes, :comment, foreign_key: true

    add_reference :posts, :user, foreign_key: true

    add_reference :reviews, :user, foreign_key: true
    add_reference :reviews, :post, foreign_key: true

    add_reference :notifications, :user, foreign_key: true
    add_reference :notifications, :post, foreign_key: true

    add_reference :comments, :user, foreign_key: true
    add_reference :comments, :post, foreign_key: true
  end
end
