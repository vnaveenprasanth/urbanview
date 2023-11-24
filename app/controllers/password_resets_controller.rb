class PasswordResetsController < ApplicationController
  def new
  end

  def create
    if @user = User.find_by_email(params[:email])
      PasswordMailer.with(user: @user).reset.deliver_later
    end
    redirect_to '/login', notice: 'Sent a link to reset password!'
  end

  def edit
    @user = User.find_signed!(params[:token], purpose: 'password_reset')
      rescue ActiveSupport::MessageVerifier::InvalidSignature
    redirect_to '/login', alert: 'Your token has expired. Please try again'
  end

  def update
    if params[:user][:password] == params[:user][:password_confirmation]
      @user = User.find_signed!(params[:token], purpose: 'password_reset')
      if @user.update(password_params)
        redirect_to '/login', allow_other_host: true, notice: 'Please sign in!'
      else
        render 'edit'
      end
    end
      rescue ActiveSupport::MessageVerifier::InvalidSignature
      redirect_to '/login', alert: 'Your token has expired. Please try again'
  end
 

  private
  
  def password_params
    params.require(:user).permit(:password, :password_confirmation)
  end

end
