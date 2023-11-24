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

    def interested_count
       interactions.where(option: 'interested').count
    end

    def not_interested_count
        interactions.where(option: 'not_interested').count
    end

    def maybe_count
        interactions.where(option: 'maybe').count
    end

    def tags_array
        tags.split(',').map(&:strip)
    end
end