class ResetPasswordsController < ApplicationController
  before_filter :check_user, only: [:edit,:update]

  def create
    user = User.find_by_email(params[:reset_password][:email])
    if user
      user.send_reset_password
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    else
      flash.now[:error]= "There's no user with such email"
      render 'new'
    end
  end

  def new
  end

  def edit
  end

  def update
    if @user.reset_password_sent_at < 2.hours.ago
      redirect_to reset_password_path, :alert => "Password reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password has been reset"
    else
      render :edit
    end
  end

  private

  def check_user
    @user = User.find_by_reset_password_token(params[:reset_password_token])
    redirect_to root_url if @user.nil?
  end
end
