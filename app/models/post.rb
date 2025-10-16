class Post < ApplicationRecord
  has_one_attached :image

  belongs_to :user

  has_many :commnets
  has_many :reviews
  has_many :likes
  has_many :notifications

  validates :title, :body, presence: true

  def get_image
    if image.attached?
      image
    else
      'no_image.jpg'
    end
  end

   # Ransackで検索可能なカラムを指定
   def self.ransackable_attributes(auth_object = nil)
    %w[title body]  # 検索したいカラムだけ
  end

  # Ransackで検索可能な関連（今回は不要）
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
