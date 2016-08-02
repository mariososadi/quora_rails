class SessionController < ApplicationController
  def new
  end

def create
  @user = User.find_by(email: params[:session][:email].downcase)
  if User.authenticate(@user.email, @user.password) 
    session[:user_id] = @user.id
    redirect_to @user
  else
    flash.now[:danger] = 'Invalid email/password combination'
    render 'new'
  end
end

  def destroy
    log_out
    redirect_to root_url  
  end
end
