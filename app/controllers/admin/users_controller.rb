class Admin::UsersController < ApplicationController
  before_action :admin_only
  before_action :set_user, only: [ :edit, :update, :destroy, :spoof_user]

  def new
    @user = User.new
  end

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def edit
  end

  def show
  end

  def update
    if @user.update_attributes(user_params)
    redirect_to admin_users_path
    else
      render :edit
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      # session[:user_id] = @user.id # auto log in
      redirect_to admin_users_path, notice: "#{@user.firstname} added as admin!"
    else
      flash.now[:alert] = "Sign Up failed..."
      render :new
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: "User has been removed!"
    else
      flash.now[:alert] = "Delete action has failed..."
      render :index
    end
  end

  def spoof_user
    session[:spoof_user_id] = @user.id
    session[:preview_mode] = true
    redirect_to movies_path, notice: "You are now logged in as #{current_user.full_name}"
  end

  protected

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end
