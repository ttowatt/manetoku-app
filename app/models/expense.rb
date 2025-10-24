class Expense < ApplicationRecord
  belongs_to :user
  belongs_to :period
  belongs_to :category

  validates :amount, presence: true, numericality: {only_integer: true}
  validates :expense_date, presence: true

end
