class Period < ApplicationRecord
  belongs_to :user

  has_many :expenses, dependent: :destroy
  has_many :categories, dependent: :destroy

  validates :start_date, :end_date, presence: true
end
