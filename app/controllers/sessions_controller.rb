class SessionsController < ApplicationController
  
  # render a form
  def new
    
  end
  
  # form sumbission
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id]  = user.id # saving user_id in sessions, cookies will handle this and use for request
      flash[:success] = "You have successfully logged in"
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Information doesn't match"
      render 'new'  
    end
  end
  
  # for logging out
  def destroy
    session[:user_id] = nil
    flash[:success] = "You have logged out"
    redirect_to root_path
  end
  
end