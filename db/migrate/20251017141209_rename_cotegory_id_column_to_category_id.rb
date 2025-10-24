class RenameCotegoryIdColumnToCategoryId < ActiveRecord::Migration[6.1]
  def change
    rename_column :expenses, :cotegory_id, :category_id
  end
end
