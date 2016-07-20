class Admin::UsersController < ApplicationController
  before_action :admin_only
  before_action :set_user, only: [ :edit, :update]

  def new
    @user = User.new
  end

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def edit
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

  protected

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end
