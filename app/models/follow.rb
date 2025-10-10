class Follow < ApplicationRecord
  belongs_to :follower_id
  belongs_to :followed_id
end
