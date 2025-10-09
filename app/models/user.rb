class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_one_attached :image

         has_many :category
         has_many :active_relationships, class_name: "Follow", foreign_key: "follower_id", dependent: :destroy
         has_many :following, through: :relationships, source: :followed
         has_many :reverse_relationships, class_name: "Follow", foreign_key: "followed_id", dependent: :destroy
         has_many :followers, through: :reverse_relationships, source: :follower

  def self.ransackable_attributes(auth_object = nil)
    %w[username]
  end

  def self.ransackable_associations(auth_object = nil)
    []
  end
end
