class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         has_many :foods, dependent: :destroy
         validates :name, presence: true
         validates :profile, length: { maximum: 200 }
         has_many :foods, dependent: :destroy
         has_many :likes, dependent: :destroy
  has_many :liked_foods, through: :likes, source: :food
  has_many :comments, dependent: :destroy
  mount_uploader :image, ImageUploader

  def already_liked?(food)
    self.likes.exists?(food_id: food.id)
  end

end
