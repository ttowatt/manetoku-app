class Expense < ApplicationRecord
  has_many  :histories, dependent: :destroy
  belongs_to :category

  validates :amount, presence: true, numericality: {only_integer: true}
  validates :expense_date, presence: true

end
