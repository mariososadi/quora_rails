class QuestionController < ApplicationController
  def show
    redirect_if_not_logged_in  
    @question = Question.all
    @user = User.all
  end

  def id
    redirect_if_not_logged_in
    @question = Question.find(params[:id])
    @user = User.all  
  end

  def new
    redirect_if_not_logged_in    
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      @user = User.find(session[:user_id])
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def question_params
      params[:question][:user_id] = session[:user_id]
      params[:question][:quest_date] = DateTime.now
      params.require(:question).permit(:title, :body, :user_id)
    end

end


# Usar con before save mejor :quest_date => DateTime.now