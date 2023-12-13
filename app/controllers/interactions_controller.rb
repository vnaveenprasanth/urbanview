class InteractionsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    option = params[:option]

    existing_interaction = @post.interactions.find_by(user_id: current_user.id)

    if existing_interaction
      if existing_interaction.option == option
        existing_interaction.destroy
        flash[:notice] = 'Your response is removed.'
      else
        existing_interaction.update(option: option)
        flash[:notice] = 'Your response is updated.'
      end
    else
      @post.interactions.create(user_id: current_user.id, option: option)
      flash[:notice] = 'Your response is recorded.'
    end

    broadcast_interactions

    redirect_to @post
  end

  private

  def broadcast_interactions
    ActionCable.server.broadcast "interaction_channel_#{params[:post_id]}", {
      post: @post,
      going_count: @post.going_count,
      not_going_count: @post.not_going_count,
      maybe_count: @post.maybe_count,
      donated_count: @post.donated_count,
      like_count: @post.like_count,
      dislike_count: @post.dislike_count
    }
  end
end