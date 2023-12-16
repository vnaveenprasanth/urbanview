class User < ApplicationRecord
    has_many :posts
    
    has_one_attached :avatar

    validates :username, presence: true, uniqueness: true, length:{minimum: 3, maximum: 25}
    
    VALID_EMAIL_REGEX = /\A[^@\s]+@([^@.\s]+\.)+[^@.\s]+\z/
    
    validates :email, presence:true, length:{maximum: 125},
    format:{with: VALID_EMAIL_REGEX}
    
    has_many :comments, dependent: :destroy

    has_many :interactions, dependent: :destroy
    # has_many :interacted_posts, through: :interactions, source: :post

    has_many :followers, class_name: 'Follow', foreign_key: 'followed_id'
    has_many :following, class_name: 'Follow', foreign_key: 'follower_id'
    has_many :follower_users, through: :followers, source: :follower
    has_many :following_users, through: :following, source: :followed


    has_many :chats, dependent: :destroy

    def attended_events
      going_posts = interactions.where(option: 'going').map(&:post)
      going_posts.map {|post| { id: post.id, title: post.title } }
    end

    def hosted_events
      hosted_posts = posts.where(post_type: 'Events')
      hosted_posts.map {|post| {id: post.id, title: post.title}}
    end

    def user_interests
      interacted_posts = interactions.includes(:post).map(&:post)
      tags = interacted_posts.flat_map(&:tags_array).uniq
    end

    def published_posts
      posts
    end

    def published_posts_count
      usersPosts = posts
      usersPosts.count
    end
  
    has_secure_password
end 