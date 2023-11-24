class SessionsController < ApplicationController 

    def new
    end

    def create 
        @user = User.find_by(email: params[:session][:email])
        if @user && @user.authenticate(params[:session][:password])
            session[:user_id] = @user.id
            redirect_to root_url,  notice: 'Logged in successfully!'
        else 
            flash.now[:error] ='Something is wrong with credential details!'
            render 'new',status: :unprocessable_entity
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to login_path, notice: 'Logged out!'
    end

end