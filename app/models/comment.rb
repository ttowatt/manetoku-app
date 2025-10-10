class Comment < ApplicationRecord
  has_many :like
  belongs_to :user
  belongs_to :post

  validates :body, presence: true
end
