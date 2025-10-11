class Category < ApplicationRecord
  belongs_to :user
  has_many :expense
  has_many :history

  validates :Category_name, presence: true
  validates :budget, presence: true, numericality: {only_integer: true}
end
