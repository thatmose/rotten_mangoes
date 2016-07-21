class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}!"
    else
      render :new
    end
  end

  def destroy
    if preview_mode?
      session.delete(:spoof_user_id)
      session.delete(:preview_mode)
    else
      session[:user_id] = nil
    end
    redirect_to movies_path, notice: "Adios!"
  end

end
