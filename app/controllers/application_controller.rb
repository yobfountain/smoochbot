class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def must_be_admin
    unless user_signed_in? and current_user.is_admin?
    flash[:notice] = "You are not authorized to view that page."
    redirect_to root_url
    end
  end
end
