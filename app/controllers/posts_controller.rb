class PostsController < ApplicationController
  before_action :require_login, except: [:index] 


    def show
        if session[:user_id]
            @user = User.find(session[:user_id])
        end
        @post = Post.find(params[:id])
    end

    def index 
        if session[:user_id]
            @user = User.find(session[:user_id])
        end

        if params[:query].present?
            @posts = Post.where("title LIKE ? OR description LIKE ? OR location LIKE ? OR tags LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%", "%#{params[:query]}%")
          else
            @active_tab = params[:tab]
            case params[:tab]
            when 'Events'
              @posts = Post.where("post_type LIKE ? AND location LIKE ?", "%Events%", "%#{params[:location]}%")
            when 'News'
              @posts = Post.where("post_type LIKE ? AND location LIKE ?", "%News%", "%#{params[:location]}%")
            when 'Jobs'
              @posts = Post.where("post_type LIKE ? AND location LIKE ?", "%Jobs%", "%#{params[:location]}%")
            when 'Charity'
              @posts = Post.where("post_type LIKE ? AND location LIKE ?", "%Charity%", "%#{params[:location]}%")
            when 'Explore'
              @posts = Post.all
            else
              @posts = Post.where("location LIKE ?", "%#{params[:location]}%")
            end
          end

    end

    def new 
        if session[:user_id]
            @user = User.find(session[:user_id])
        end
        @post = Post.new
    end

    def edit
        if session[:user_id]
            @user = User.find(session[:user_id])
        end
        @post = Post.find(params[:id])
    end

    def create
        if session[:user_id]
            @user = User.find(session[:user_id])
        end
        @post = Post.new(post_params)
        @post.user = current_user
        if @post.save
            if params[:post][:images].present? && params[:post][:images].length > 1
                params[:post][:images].drop(1).each do |image|
                upload_result = Cloudinary::Uploader.upload(image)
                @post.urls << (upload_result['secure_url'])
                @post.save
                end
            else
                upload_result = Cloudinary::Uploader.upload('https://images3.alphacoders.com/133/1337543.png')
                @post.urls << (upload_result['secure_url'])
                @post.save
            end
            current_user.followers.each do |follower|
            user = follower.follower
            PostMailer.new_post_notification(user, @post).deliver_now
        end
            redirect_to @post, notice: 'Post was successfully created.'
        else
      
            render :new,status: :unprocessable_entity
        end
        
    end

    def update 
        if session[:user_id]
            @user = User.find(session[:user_id])
        end

        @post = Post.find(params[:id])
        
        delete_image_indices = extract_indices(params[:post])
        urls_array = @post.urls
        delete_image_indices.each { |index| urls_array.delete_at(index) }

        if params[:post][:images].present?
            params[:post][:images].drop(1).each do |image|
            upload_result = Cloudinary::Uploader.upload(image)
            @post.urls << (upload_result['secure_url'])
            end
        end

        if @post.update(post_params) 
            redirect_to @post, notice: 'Post was successfully updated.'
          else
            render :edit
          end
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy
        redirect_to posts_path
    end
    
    private

    def post_params
      params.require(:post).permit(:title, :description, :location, :tags,:enable_event, :start_date, :end_date, :post_type)
    end

    def require_login
      unless logged_in?
        flash[:error] = "You must be logged in to access this section"
        redirect_to login_path
      end
    end

    def extract_indices(post_params)
      delete_image_params = post_params.select { |key, value| key.starts_with?('delete_image_') && value == '1' }
      delete_image_params.keys.map { |key| key.scan(/\d+/).first.to_i }
    end
end