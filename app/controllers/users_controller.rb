class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def index
    @users = User.activated.paginate page: params[:page],
     per_page: Settings.per_page
  end

  def show
    redirect_to root_path && return unless @user.activated?
    @microposts = @user.microposts.paginate page: params[:page],
     per_page: Settings.per_page
  end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t "pls"
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t "del"
      redirect_to users_path
    else
      flash[:danger] = t "notdel"
      redirect_to root_path
    end
  end

  def updates
    if @user.update_attributes(user_params)
      flash[:success] = t "update"
      redirect_to @user
    else
      render :edit
    end
  end

  def edit; end

  def following
    @title = t "following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate page: params[:page],
     per_page: Settings.per_page
    render "show_follow"
  end

  def followers
    @title = t "follower"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate page: params[:page],
     per_page: Settings.per_page
    render "show_follow"
  end

  private

  def user_params
    params
      .require(:user).permit :name, :email, :password, :password_confirmation
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "logged"
    redirect_to login_path
  end

  def correct_user
    redirect_to root_path unless current_user?(@user)
  end

  def admin_user
    redirect_to root_path unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "messenger"
    redirect_to root_path
  end
end
