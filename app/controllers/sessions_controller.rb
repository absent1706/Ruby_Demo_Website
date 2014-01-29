class SessionsController < ApplicationController
include SessionsHelper
  def new
  end

  def create
    $debug_info=params[:session]
    user = User.find_by_email(params[:session][:email].downcase)
    if user && user.active && user.authenticate(params[:session][:password])
       #sign_in (user)
       redirect_back_or user
    else
      flash.now[:error] = user.exists ? 'Invalid email/password combination' : 'User is inactive. Check your email to activate.' # Not quite right!
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_url
  end
end