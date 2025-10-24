class Notification < ApplicationRecord
  belongs_to :visitor, class_name: "user", foreign_key: "visitor_id"
  belongs_to :visited, class_name: "user", foreign_key: "visited_id"
  belongs_to :post
end
