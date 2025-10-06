class CreateExpenses < ActiveRecord::Migration[6.1]
  def change
    create_table :expenses do |t|

      t.integer :cotegory_id
      t.integer :amount
      t.date :expense_date

      t.timestamps
    end
  end
end
