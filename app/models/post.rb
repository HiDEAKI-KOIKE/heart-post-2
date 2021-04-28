class Post < ApplicationRecord
  belongs_to :user
  
 validates :content, presence: true, length: { maximum: 255 }
 validates :emotion, presence: true
  
  has_many :favorites, dependent: :destroy
  has_many :favoriters, through: :favorites, source: :user
end
