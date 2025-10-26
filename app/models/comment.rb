class Comment < ApplicationRecord
  has_many :comment_likes
  belongs_to :user
  belongs_to :post

  validates :body, presence: true
end
