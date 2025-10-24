class AddNotNullConstraintToPostsCategory < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :category, false
  end
end
