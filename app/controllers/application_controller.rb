class ApplicationController < ActionController::Base
   
    helper_method :current_user, :logged_in?, :current_user_instance
    
    def current_user 
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end

    def logged_in?
        !!current_user
    end

    def current_user_instance
        @user = User.find(session[:user_id])
    end
end
