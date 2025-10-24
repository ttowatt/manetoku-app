class AddColumnInPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :category, :string
    add_index :posts, :category
  end
end
