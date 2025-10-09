class Expense < ApplicationRecord
  has_many  :history
  belongs_to :category

  varidates :amount, :expense_date, presence: true, numericality: {only_integer: true}
  varidates :expense_date, presence: true

end
