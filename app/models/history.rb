class History < ApplicationRecord
  belongs_to :Category
  belongs_to :expense
end
