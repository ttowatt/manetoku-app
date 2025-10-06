class CreateHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :histories do |t|

      t.integer :category_id
      t.integer :expense_id

      t.timestamps
    end
  end
end
