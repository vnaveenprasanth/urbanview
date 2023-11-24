class Interaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :option, inclusion: {in: %w[interested not_interested maybe]}
end
