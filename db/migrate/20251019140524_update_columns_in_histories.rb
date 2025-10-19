class UpdateColumnsInHistories < ActiveRecord::Migration[6.1]
  def change
    remove_column :histories, :category_id, :integer

    add_reference :histories, :user, foreign_key: true
  end
end
