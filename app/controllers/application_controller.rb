class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :switch_check, only: [:switch_back]

  def switch_back
      session.delete(:spoof_user_id)
      session.delete(:preview_mode)
      current_user
      redirect_to admin_users_path, notice: "Preview_mode ended"
  end

  protected
  def admin_only
    unless current_user.admin
      flash[:alert] = "You do not have admin privileges."
      redirect_to movies_path
    end
  end

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def current_user
    if session[:spoof_user_id]
      @current_user = User.find(session[:spoof_user_id])
    else
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
  end

  def preview_mode?
    session[:preview_mode]
  end

  def switch_check
    unless preview_mode? && User.find(session[:user_id]).admin
      flash[:alert] = "We cannot verify your admin status!"
      redirect_to movies_path
    end
  end

  helper_method :current_user
  helper_method :preview_mode?

end
