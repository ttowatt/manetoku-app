class Category < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy
  has_many :histories, dependent: :destroy

  validates :category_name, presence: true
  validates :budget, presence: true, numericality: {only_integer: true}
end
