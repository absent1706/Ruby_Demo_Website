class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
  		@users=User.all
  end

    def show
    @user = User.find(params[:id])
  end

  
   def create
    @user = User.new(params[:user])
    flash[:success] = "Welcome to the Sample App!"
    if @user.save
      redirect_to @user
    else
      render 'new'
    end
  end


 end
