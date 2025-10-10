class AddNotNullConstraints < ActiveRecord::Migration[6.1]
  def change
    change_column_null :users, :last_name, false
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name_kana, false
    change_column_null :users, :first_name_kana, false
    change_column_null :users, :username, false
    change_column_null :users, :introduction, false
    change_column_null :users, :phone_number, false

    change_column_null :posts, :title, false
    change_column_null :posts, :body, false

    change_column_null :comments, :body, false

    change_column_null :reviews, :star, false
    change_column_null :reviews, :body, false

    change_column_null :categories, :category_name, false
    change_column_null :categories, :budget, false

    change_column_null :expenses, :amount, false
    change_column_null :expenses, :expense_date, false
  end
end
