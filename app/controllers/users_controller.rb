class UsersController < ApplicationController
  before_filter :find_user,:only=>[:edit,:show,:update]
  before_filter :signed_in_user, only: [:edit, :update,:index, :destroy]
  before_filter :correct_user,   only: [:edit, :update]
  before_filter :admin_user,     only: :destroy

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
    @users=User.paginate(page: params[:page])
  end

  def show
    @microposts = @user.microposts.paginate(page: params[:page])
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


  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
  end

  private

  def find_user
    @user = User.find(params[:id])
  end



  #если юзер хочет отредактировать чужие данные, отправляем его на домашнюю страницу сайта
  def correct_user
    redirect_to(root_path) unless current_user?(@user)
  end

  #при попытке удаления юзеров проверяем, админ ли это делает. Если нет, перенаправляем.
  def admin_user
    redirect_to(root_path) unless current_user.admin?
  end

end
