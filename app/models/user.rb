class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :profile_image

         has_many :periods, dependent: :destroy
         has_many :categories, dependent: :destroy
         has_many :expenses, dependent: :destroy
         has_many :posts, dependent: :destroy
         has_many :likes, dependent: :destroy
         has_many :comments, dependent: :destroy
         has_many :reviews, dependent: :destroy

         has_many :active_notifications, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
         has_many :reverse_notifications, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

         has_many :active_relationships, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
         has_many :following, through: :active_relationships, source: :followed
         has_many :reverse_relationships, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
         has_many :followers, through: :reverse_relationships, source: :follower

         validates :password, presence: true, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}\z/ }, if: :password_required?
         validates :last_name, :first_name, presence: true, format: {with: /\A[\p{Han}　]+\z/}
         validates :last_name_kana, :first_name_kana, presence: true, format: {with: /\A[\p{Katakana}ー　]+\z/}
         validates :username, presence: true, uniqueness: {case_sensitive: false}
         validates :phone_number, presence: true, format: {with: /\A\d{10,11}\z/}

  def get_profile_image
    if profile_image.attached?
      profile_image
    else
      'no_image.jpg'
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[username]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
