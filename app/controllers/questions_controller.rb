class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    query = params[:q].presence || "*"
    @questions = Question.search(query)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user

    if @question.save
      flash[:notice] = 'Question was successfully created.'
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @answer = Answer.new
  end

  def update
    if @question.update(question_params)
      invoke_cables
      redirect_to @question, notice: "This question was updated."
    else
      render :edit
    end
  end

  def destroy
    @question.destroy
    redirect_to root_path, notice: "Question was successfully destroyed."
  end

  def autocomplete
    render json: Question.search(params[:term], fields: [{title: :text_start}], limit: 10).map(&:title)
  end

  private

  def set_question
    @question = Question.find_by(hash_id: params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def invoke_cables
    CableServices::NotifyJobsService.(
      question: @question,
      action: action_name.to_sym,
      user: current_user
    )
  end
end
