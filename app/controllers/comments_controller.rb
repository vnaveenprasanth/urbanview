class CommentsController < ApplicationController
    
    def create
        @post = Post.find(params[:post_id])
        @comment = @post.comments.build(comment_params)
        @comment.user = current_user
    
        if @comment.save
          redirect_to @post, notice: 'Comment was successfully created.'
        else
          render 'posts/show'
        end
    end
    
    def edit
        if session[:user_id]
          @user = User.find(session[:user_id])
        end
        @comment = Comment.find(params[:id])
        @post = @comment.post
        authorize_user(@comment.user)
    end
    
    def update
        @comment = Comment.find(params[:id])
        @post = @comment.post
        authorize_user(@comment.user)
    
        if @comment.update(comment_params)
          redirect_to @post, notice: 'Comment was successfully updated.'
        else
          render :edit
        end
    end
    
    def destroy
        @comment = Comment.find(params[:id])
        @post = @comment.post
        authorize_user(@comment.user)
 
        @comment.destroy
        redirect_to post_path(@post), notice: 'Comment was successfully deleted.'

    end
    
      private
    
      def comment_params
        params.require(:comment).permit(:content)
      end
    
      def authorize_user(comment_user)
        unless comment_user == current_user
          redirect_to root_path, alert: 'You are not authorized to perform this action.'
        end
      end
end
