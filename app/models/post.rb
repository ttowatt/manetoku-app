class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  has_many :commnet
  has_many :review
  has_many :like
  has_many :notification

  validates :title, :body, presence: true

   # Ransackで検索可能なカラムを指定
   def self.ransackable_attributes(auth_object = nil)
    %w[title body]  # 検索したいカラムだけ
  end

  # Ransackで検索可能な関連（今回は不要）
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
