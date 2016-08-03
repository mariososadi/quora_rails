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
    @vote = QuestionVote.find_by(question_id: @question.id) 
  end

  def new
    redirect_if_not_logged_in    
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      QuestionVote.create(question_id: @question.id)
      @user = User.find(session[:user_id])
      redirect_to @user
    else
      render 'new'
    end
  end

  def vote
    redirect_if_not_logged_in   
    @vote = QuestionVote.find(params[:q_vote_id])
    @type = params[:type]
    if @type == 'plus'
      QuestionVote.increment_counter(:counter, @vote.id)
      @data = QuestionVote.find(params[:q_vote_id]).counter
      render json: @data.to_json
    else
      @data = QuestionVote.decrement_counter(:counter, @vote.id)
      @data = QuestionVote.find(params[:q_vote_id]).counter
      render json: @data.to_json
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