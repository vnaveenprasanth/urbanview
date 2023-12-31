class ChatChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_channel_#{params[:post_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_message(data)
    @user = User.find(data['user_Id'])
    @post = Post.find(data["post_Id"])
  
    chat = @post.chats.create({
      post_id: data['post_id'],
      user_id: data['user_Id'],
      content: data['message']
    })
  
    avatar_url = user_avatar_url(@user)
  
    ActionCable.server.broadcast "chat_channel_#{params[:post_id]}", {
      message: data['message'],
      post_Id: data['post_Id'],
      user_Id: data['user_Id'],
      username: @user.username,
      avatar_url: avatar_url
    }
  end
  
  def user_avatar_url(user)
    return unless user.avatar.key
  
    Cloudinary::Utils.cloudinary_url(user.avatar.key, width: 100, height: 100, crop: :thumb)
  end
  

end
