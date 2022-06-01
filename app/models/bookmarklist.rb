class Bookmarklist < ApplicationRecord
  belongs_to :user
  has_many :savedposts , dependent: :destroy
  has_many :microposts , through: :savedposts
  validates :user_id , presence: true
  validates :name, presence: true, length: {maximum: 20}
end
