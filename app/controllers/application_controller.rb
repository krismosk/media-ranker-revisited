class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :find_current_user

  def render_404
    # DPR: this will actually render a 404 page in production
    raise ActionController::RoutingError.new("Not Found")
  end

  def find_current_user
    if session[:user_id]
      @login_user ||= User.find_by(id: session[:user_id])
    end
  end

  def require_login
    if session[:user_id].nil?
      flash[:status] = :failure
      flash[:result_text] = "You must be logged in to view this page."
      return redirect_to root_path
    end
  end


end
