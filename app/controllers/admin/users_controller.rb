class Admin::UsersController < ApplicationController
  def new
    @user = User.new
  end

  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id # auto log in
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      flash.now[:alert] = "Log in failed..."
      render :new
    end
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end
end
