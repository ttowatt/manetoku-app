class RenameFollowedIdColumnToFollows < ActiveRecord::Migration[6.1]
  def change
    rename_column :follows, :followed__id, :followed_id
  end
end
