class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :books, dependent: :destroy#1対Nの関係。アソシエーション。（モデル同士の紐付け）
  has_many :book_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  attachment :profile_image
  validates :name, presence: true,  length: { minimum: 2, maximum: 20}#名前は2文字以上20文字以内。それ以外はエラーを表示。
  validates :introduction, length: { maximum: 50}#感想が50文字を超える場合はエラーを表示。
end


