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







  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    def admin?
    self.role == "admin"
  
    end

validates_presence_of :name
 
    def first_name
       self.name.split.first
    end
    def last_name
     self.name.split.last_name
    end







end
