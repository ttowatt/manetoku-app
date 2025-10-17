class Expense < ApplicationRecord
  has_many  :histories
  belongs_to :category

  validates :amount, presence: true, numericality: {only_integer: true}
  validates :expense_date, presence: true

end
