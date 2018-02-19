class AnswersController < ApplicationController
  before_action :set_question, only: [:create, :edit, :update, :destroy]
  before_action :set_answer, only: [:edit, :update, :destroy]


  def create
    @answer = @question.answers.build(answer_params)
    @answer.user = current_user

    if @answer.save
      invoke_cables
      redirect_to question_path(@question), notice: "Your answer was added."
    else
      @answers = @question.answers.reload
      render 'questions/show'
    end
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to question_path(@question), notice: 'Your answer was updated.'
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to question_path(@question), notice: 'Your answer was deleted.'
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def invoke_cables
    CableServices::NotifyJobsService.(
      @question
    )
  end

  def set_question
    @question = Question.find_by(hash_id: params[:question_id])
  end

  def set_answer
    @answer = Answer.find_by(hash_id: params[:id])
  end
end
