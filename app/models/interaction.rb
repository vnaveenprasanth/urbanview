class Interaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :option, inclusion: {in: %w[going not_going maybe donated like dislike]}
end
