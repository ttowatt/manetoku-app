class Category < ApplicationRecord
  belongs_to :user
  has_many :expenses
  has_many :histories

  validates :Category_name, presence: true
  validates :budget, presence: true, numericality: {only_integer: true}
end
