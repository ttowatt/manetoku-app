class AddColumnsInExpenses < ActiveRecord::Migration[6.1]
  def change
    add_reference :expenses, :user, foreign_key: true
    add_reference :expenses, :period, foreign_key: true
    add_reference :expenses, :category, foreign_key: true
  end
end
