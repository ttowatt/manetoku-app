class Category < ApplicationRecord
  belongs_to :user
  has_many :expenses, dependent: :destroy
  accepts_nested_attributes_for :expenses, allow_destroy: true
  has_many :histories, dependent: :destroy

  validates :Category_name, presence: true
  validates :budget, presence: true, numericality: {only_integer: true}
end
