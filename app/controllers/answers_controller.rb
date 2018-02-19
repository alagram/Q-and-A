class AnswersController < ApplicationController

  def create
    @question = Question.find_by(hash_id: params[:question_id])
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

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def invoke_cables
    CableServices::NotifyJobsService.(
      @question
    )
  end
end
