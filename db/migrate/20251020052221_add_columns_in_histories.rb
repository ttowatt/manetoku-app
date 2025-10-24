class AddColumnsInHistories < ActiveRecord::Migration[6.1]
  def change
    add_reference :histories, :user, foreign_key: true
    add_reference :histories, :period, foreign_key: true
  end
end
