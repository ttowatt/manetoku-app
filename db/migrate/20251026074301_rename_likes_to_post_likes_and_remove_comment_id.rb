class RenameLikesToPostLikesAndRemoveCommentId < ActiveRecord::Migration[6.1]
  def change
      # まず外部キー制約を削除
      remove_foreign_key :likes, :comments
  
      # 次に comment_id カラムを削除
      remove_column :likes, :comment_id, :integer
  
      # インデックスも削除（存在すれば）
      remove_index :likes, :comment_id if index_exists?(:likes, :comment_id)
  
      # テーブル名を変更
      rename_table :likes, :post_likes
  end
end
