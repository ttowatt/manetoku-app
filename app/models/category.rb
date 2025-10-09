class Category < ApplicationRecord
  has_many :user
  belongs_to :expense
  belongs_to :history

  validates :Category_name, presence: true
  validates :budget, presence: true, numericality: {only_integer: true}
end
