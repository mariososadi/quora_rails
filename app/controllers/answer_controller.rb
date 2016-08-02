class AnswerController < ApplicationController

  def new
    redirect_if_not_logged_in    
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      @user = User.find(session[:user_id])
      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def answer_params
      params[:answer][:user_id] = session[:user_id]
      params[:answer][:question_id] = params[:id]
      params[:answer][:quest_date] = DateTime.now
      p params
      params.require(:answer).permit(:body, :user_id, :question_id, :quest_date)
    end



end
