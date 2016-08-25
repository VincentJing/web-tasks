class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  private

  def require_login
    unless session[:status]
      flash[:error] = '你当前未登录，请登录！'
      redirect_to login_admins_path
    end
  end
end
