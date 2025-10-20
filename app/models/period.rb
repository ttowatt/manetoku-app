class Period < ApplicationRecord
  belongs_to :user

  has_many :expenses, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :start_date, presence: true
  validates :end_date, presence: true
end
