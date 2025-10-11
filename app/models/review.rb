class Review < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :star, presence: true, 
                   numericality: {only_integer: true, greater_than: 0, less_than_or_equal_to: 5}
  validates :body, presence: true
end
