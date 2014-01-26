class ResetPasswordsController < ApplicationController

  def create
    user = User.find_by_email(params[:reset_password][:email])
    if user
      #user.send_password_reset
      redirect_to root_url, :notice => "Email sent with password reset instructions."
    else
      flash.now[:error]= "There's no user with such email"
      render 'new'
    end
  end

  def new
  end

end
