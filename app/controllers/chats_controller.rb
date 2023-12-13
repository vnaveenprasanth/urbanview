class ChatsController < ApplicationController
  def create
    # ChatChannel.broadcast_to(@post, @chat)
  end

  private

  def chat_params
    params.require(:chat).permit(:content)
  end

end
