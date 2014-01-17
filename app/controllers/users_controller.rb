class UsersController < ApplicationController
  before_filter :find_user,:only=>[:edit,:show,:update]  
  before_filter :check_authentification, only: [:edit, :update]
  before_filter :check_user, only: [:edit, :update]
  def new
    @user = User.new
  end

  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def index
    @users=User.all
  end

  def show
  end


  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def find_user
    @user = User.find(params[:id])
  end 

  def check_authentification
    #если юзер вообще не авторизован, отправляем его на страницу авторизации
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end

  def check_user
    #если юзер хочет отредактировать чужие данные, отправляем его на домашнюю страницу сайта
    redirect_to(root_path) unless current_user?(@user)
  end
  
end
