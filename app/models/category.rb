class Category < ApplicationRecord
  belongs_to :user
  belongs_to :period
  
  has_many :expenses, dependent: :destroy

  validates :category_name, presence: true
  validates :budget, presence: true, numericality: {only_integer: true}
end
