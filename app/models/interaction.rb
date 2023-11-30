class Interaction < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :option, inclusion: {in: %w[going not_going maybe donated like dislike]}

  after_commit :send_going_emails, if: :option_going?

  private

  def option_going?
    option == 'going'
  end

  def send_going_emails
    threshold = 2

    going_users = post.interactions.where(option: 'going').map(&:user).uniq

    if going_users.count >= threshold
      going_users.each do |user|
        PostMailer.going_notification(user, post,going_users.count).deliver_now
      end
    end
  end

end
