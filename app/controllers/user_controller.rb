class UserController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    redirect_if_not_logged_in    
    @user = User.find(params[:id])
    @question = Question.all
    @answer = Answer.all    
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password)
    end

end
