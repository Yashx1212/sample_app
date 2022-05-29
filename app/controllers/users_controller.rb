class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy, :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def new
    # debugger
    @user = User.new
  end

  def show 
    redirect_to root_url and return unless logged_in? 
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def create
    @user = User.new(user_params)
    #@user.send_activation_email
    if @user.save
      # Handle a successful save.
      UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
      # log_in @user
      # flash[ :success] = "Welcome to the Sample App !"
      # redirect_to @user
    else
      render 'new'
    end 
  end

  def index
    @users = User.where(activated: true).paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end 
  
  def update

    if @user.update(user_params)
      flash[ :success] = "Profile Updated"
      redirect_to @user
    else
      render 'edit'
    end

  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
    end

  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end

  def bookmarklists
    @user = User.find(params[:id])
    @bookmarklist = @user.bookmarklists.build
    render 'show_bookmark_list'
  end

  private
    def user_params
      params.fetch(:user ,{}).permit(:name, :email, :password, :password_confirmation => {})
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end

