class InteractionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "interaction_channel_#{params[:post_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
