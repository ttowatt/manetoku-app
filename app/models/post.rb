class Post < ApplicationRecord
  has_one_attached :post_image

  belongs_to :user

  has_many :comments, dependent: :destroy
  has_many :reviews, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  validates :title, :body, :category, presence: true

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

  #検索機能
  after_create :create_notifications_to_followers

  private

  def create_notifications_to_followers
    # 投稿者をフォローしている全員に通知を作成
    user.followers.each do |follower|
      Notification.create!(
        visitor_id: user.id,     # 投稿者
        visited_id: follower.id, # 通知を受け取る人
        post_id: id,
        is_read: false
      )
    end
  end
end
