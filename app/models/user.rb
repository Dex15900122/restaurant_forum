class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable


mount_uploader :avatar, AvatarUploader
# 「使用者評論很多餐廳」的多對多關聯
has_many :comments, dependent: :restrict_with_error
has_many :restaurants, through: :comments
 # 「使用者收藏很多餐廳」的多對多關聯
has_many :favorites, dependent: :destroy
has_many :favorited_restaurants, through: :favorites, source: :restaurant

has_many :lkes, dependent: :destroy
has_many :liked_restaurants, through: :likes, source: :restaurant 
 # 「使用者追蹤使用者」的 self-referential relationships 設定
 # 不需要另加 source，Rails 可從 Followship Model 設定來判斷 followings 指向 User Model
has_many :followships, dependent: :destroy
has_many :followings, through: :followships
 # 透過 class_name, foreign_key 的自訂，指向 Followship 表上的另一側
has_many :inverse_followships, class_name: "Followship",foreign_key: "following_id"
has_many :followers, through: :inverse_followships, source: :user

has_many :friendships, dependent: :destroy
has_many :friends, through: :friendships

has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id" #反向的交友關係 fk為friend_id

has_many :inverse_friends, through: :inverse_friendships, source: :user #加我好友的人



  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    def admin?
    self.role == "admin"
  
    end

    def following?(user)
      self.followings.include?(user)
    end

    def friending?(user)
      self.friends.include?(user)

    end

    

    def all_friends?(user)
      self.friends.include?(user) || self.inverse_friends.include?(user)
    end

    def friends?(user)
    self.friends.include?(user)
    end
    def inverse_friends?(user)
      self.inverse_friends.include?(user)
    end

    
    def friends_list
    list = []
    self.friends.each do |friend|
      list<<friend if self.inverse_friends.include?(friend)
    end
    return list
    end 


validates_presence_of :name
 
    def first_name
       self.name.split.first
    end
    def last_name
     self.name.split.last_name
    end







end
