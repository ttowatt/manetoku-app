class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :image

         has_many :category, dependent: :destroy
         has_many :Post, dependent: :destroy
         has_many :like, dependent: :destroy
         has_many :comment, dependent: :destroy
         has_many :review, dependent: :destroy

         has_many :active_notification, class_name: "Notification", foreign_key: "visitor_id", dependent: :destroy
         has_many :reverse_notification, class_name: "Notification", foreign_key: "visited_id", dependent: :destroy

         has_many :active_relationships, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
         has_many :following, through: :relationships, source: :followed
         has_many :reverse_relationships, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
         has_many :followers, through: :reverse_relationships, source: :follower

         validates :password, presence: true, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]{6,}\z/ }, if: :password_required?
         validates :last_name, :first_name, presence: true, format: {with: /\A[\p{Han}　]+\z/}
         validates :last_name_kana, :first_name_kana, presence: true, format: {with: /\A[\p{Katakana}ー　]+\z/}
         validates :username, presence: true, uniqueness: {case_sensitive: false}
         validates :phone_number, presence: true, format: {with: /\A\d{10,11}\z/}

  def self.ransackable_attributes(auth_object = nil)
    %w[username]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
