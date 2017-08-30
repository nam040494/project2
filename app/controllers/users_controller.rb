class UsersController < ApplicationController
  before_action :logged_in_user, except: %i(index)
  before_action :correct_user, only: %i(edit update)
  before_action :load_user, except: %i(index new create)
  before_action :verify_admin!, only: :destroy

  def index
    @users = User.select(:id, :name, :email).order(:name).paginate page: params[:page],
      per_page: Settings.users.index.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      @user.send_activation_email
      flash[:info] = t ".activation"
      redirect_to @user
    else
      flash.now[:danger] = t ".error"
      render :new
    end
  end

  def show
    @microposts = @user.microposts.paginate page: params[:page],
      per_page: Settings.users.index.per_page

    return @user
    flash[:danger] = t ".not_found"
    redirect_to root_url

  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".updated"
      redirect_to @user
    else
      flash.now[:danger] = t ".updated_failed"
      render :edit
    end
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".cannot_deleted"
    end
    redirect_to users_url
  end

  def following
    @title = t ".title"
    @users = @user.following.paginate page: params[:page],
      per_page: Settings.users.index.per_page
    render "show_follow"
  end

  def followers
    @title = t ".title"
    @users = @user.followers.paginate page: params[:page],
      per_page: Settings.users.index.per_page
    render "show_follow"
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def verify_admin!
    redirect_to(root_url) unless current_user.admin?
  end

  def load_user
    @user = User.find_by id: params[:id]

    return if @user
    flash[:danger] = t ".not_found"
    redirect_to root_url
  end
end
