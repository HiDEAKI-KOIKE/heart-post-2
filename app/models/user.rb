class User < ApplicationRecord
    before_save { self.email.downcase! }
    validates :name, presence: true, length: { maximum: 20 }
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                        uniqueness: { case_sensitive: false }
    has_secure_password
    
    
    has_many :posts
    has_many :favorites
    has_many :likes, through: :favorites, source: :post
    
    def favorite(other_post)
        self.favorites.find_or_create_by(post_id: other_post.id)
    end
    
    def unfavorite(other_post)
        favorite = self.favorites.find_by(post_id: other_post.id)
        favorite.destroy if favorite
    end
    
    def likes?(other_post)
        self.likes.include?(other_post)
    end
end
