class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

has_many :comments
mount_uploader :avatar, AvatarUploader

has_many :restaurants, through: :comments


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
