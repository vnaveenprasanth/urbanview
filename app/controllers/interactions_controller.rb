class InteractionsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    option = params[:option]
       
    existing_interaction = @post.interactions.find_by(user_id: current_user.id)

    if existing_interaction
        if existing_interaction.option == option
           existing_interaction.destroy
            redirect_to @post, notice: 'Your response is removed.'
        else
            existing_interaction.update(option: option)
            redirect_to @post, notice: 'Your response is updated.'
        end
    else
        @post.interactions.create(user_id: current_user.id, option: option)
        redirect_to @post, notice: 'Your response is recorded.'
    end
    
  end

    
end