class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:success] = "Successfully logged in #{user.username}"
      redirect_to user_path(user)
    elsif
      flash.now[:danger] ="Something wrong with your login. Please check credentials"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id]=nil
    flash[:success]="You have successfully logged out"
    redirect_to articles_path
  end
  
end
