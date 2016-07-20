class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

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
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
