class RemoveColumnsInHistories < ActiveRecord::Migration[6.1]
  def change
    remove_column :histories, :category_id, :integer
    remove_column :histories, :expense_id, :integer
  end
end
