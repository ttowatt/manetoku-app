class Post < ApplicationRecord
  has_one_attached :post_image

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :notifications, as: :notifiable, dependent: :destroy  

  validates :title, :body, :category, presence: true

  after_destroy :purge_post_image

  private

  after_create do
    user.followers.each do |follower|
      notifications.create(user_id: follower.id)
    end
  end

   # 投稿画像を削除(元画像削除,リサイズ済みも自動で削除)
   def purge_post_image
     post_image.purge if post_image.attached?
   end

  
  def get_post_image
    if post_image.attached?
      post_image
    else
      'no_image.jpg'
    end
  end

   # Ransackで検索可能なカラムを指定
   def self.ransackable_attributes(auth_object = nil)
    %w[title body category]  # 検索したいカラムだけ
  end

  # Ransackで検索可能な関連（今回は不要）
  def self.ransackable_associations(auth_object = nil)
    []
  end
end
