class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :name, presence: true

  has_many :prototypes
  has_many :comments

  paginates_per 8

  mount_uploader :avatar, AvatarUploader

end
