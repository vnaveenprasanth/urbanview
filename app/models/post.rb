class Post < ApplicationRecord

    # validate :valid_tags
    
    # has_one_attached :postImages
    store :imageUrls, accessors: [:urls], coder: JSON
    after_initialize do
        self.urls ||= []
    end

    validates :title, presence: true, length: {minimum: 4, maximum: 60}
    validates :description, presence: true, length: {minimum: 10, maximum: 5000}
    validates :tags, presence: true
    validates :location, presence: true
    validates :post_type, presence: true,inclusion: {in:['Events','Jobs','Charity','Explore']}
    validate :valid_event_dates

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

    def event_status
        current_time = Time.now.utc
        start_date_utc = start_date.utc if start_date.present?
        end_date_utc = end_date.utc if end_date.present?
      
        if start_date_utc.present? && end_date_utc.present?
          if current_time < start_date_utc
            'Upcoming'
          elsif current_time >= start_date_utc && current_time <= end_date_utc
            'Ongoing'
          else
            'Ended'
          end
      end
    end


    private

    def valid_tags
        valid_values = %w(Events News Jobs Charity events news jobs charity)
        valid_tags_array = tags_array.select { |tag| valid_values.include?(tag) }
        unless valid_tags_array.length == 1
        errors.add(:tags, "should contain exactly one of: #{valid_values.join(', ')}")
        end
    end

    def event_enabled?
        enable_event == true
    end

    def valid_event_dates
        return unless event_enabled?

        if start_date.present? && end_date.present? && start_date > end_date
        errors.add(:end_date, 'must be after the start date')
        end
    end
end