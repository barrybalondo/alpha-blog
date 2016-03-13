class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  # user actions are built here.
  
  helper_method :current_user, :logged_in?  # helper methods
  
  # used for our views
  def current_user
    
    # if there is a session user id stored in hash find in database
    # @current_user is used for optimization to have not multiple hits
    # in the database if current user is already in session.
    @current_user ||=User.find(session[:user_id]) if session[:user_id] 
    
  end

  def logged_in?
    # checks if current user is existing. !! returns a boolean variable hence !!current_user
    !!current_user
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action."
      redirect_to root_path
    end
  end
  
end
