class AnswerController < ApplicationController

  def new
    redirect_if_not_logged_in    
  end

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      AnswerVote.create(answer_id: @answer.id)
      @user = User.find(session[:user_id])
      redirect_to @user
    else
      render 'new'
    end
  end

  def vote
    redirect_if_not_logged_in   
    @vote = AnswerVote.find(params[:vote_id])
    @type = params[:type]
    if @type == 'plus'
      AnswerVote.increment_counter(:counter, @vote.id)
      @data = AnswerVote.find(params[:vote_id]).counter
      render json: @data.to_json
    else
      @data = AnswerVote.decrement_counter(:counter, @vote.id)
      @data = AnswerVote.find(params[:vote_id]).counter
      render json: @data.to_json
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
