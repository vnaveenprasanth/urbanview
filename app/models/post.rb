class Post < ApplicationRecord
    # has_one_attached :postImages
    store :imageUrls, accessors: [:urls], coder: JSON
    after_initialize do
        self.urls ||= []
    end

    validates :title, presence: true, length: {minimum: 4, maximum: 60}
    validates :description, presence: true, length: {minimum: 10, maximum: 5000}
    validates :tags, presence: true
    validates :location, presence: true

    belongs_to :user

    has_many :comments, dependent: :destroy
   
    has_many :interactions, dependent: :destroy
    has_many :interactors, through: :interactions, source: :user
    
    def tags_array
        tags.split(',').map(&:strip)
    end

    def going_count
       interactions.where(option: 'going').count
    end

    def not_going_count
        interactions.where(option: 'not_going').count
    end

    def maybe_count
        interactions.where(option: 'maybe').count
    end

    def donated_count
        interactions.where(option: 'donated').count
    end

    def like_count
        interactions.where(option: 'like').count
    end

    def dislike_count
        interactions.where(option: 'dislike').count
    end

    def selected_option(user)
        interaction = interactions.find_by(user_id: user.id)
        interaction&.option
      end
end