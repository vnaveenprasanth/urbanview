class UsersController < ApplicationController 
   
    def show 
      @user = User.find(params[:id])
    end

    def new
    @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def update
      @user = User.find(params[:id])
      if @user.update(updateUser_params)
        redirect_to user_path(@user), notice: 'Updated profile successfully!'
      else
        render 'edit'
      end
    end

    def create
    @user = User.new(user_params)
    
    @user.avatar.attach(io: File.open('/home/naveenprasanthv/Rails/Devise - Copy/UrbanView/app/assets/images/userimg.png'), filename: 'default_avatar.png', content_type: 'image/png')

      if @user.password == params[:user][:password_confirmation]
        if @user.save
          redirect_to login_path, notice: 'Registration successful!'
        else
          flash.now[:error] = "User creation failed!"
            render 'new',  status: :unprocessable_entity
        end
      else
        flash.now[:error] = "Check the credentials entered!"
          render 'new', status: :unprocessable_entity
      end
    end
     
  private
  
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end

  def updateUser_params
    params.require(:user).permit(:username, :email, :location, :avatar)
  end
  
end