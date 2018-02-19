class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  def index
    @questions = Question
                  .order(created_at: :desc)
                  .page(params[:page])
                  .per(5)
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
    @answers = @question.reload.answers
  end

  def update
    if @question.update(question_params)
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

  def search
    query = params[:q].presence || "*"
    @questions = Question.search(query)
  end

  private

  def set_question
    @question = Question.find_by(hash_id: params[:id])
  end

  def question_params
    params.require(:question).permit(:title, :body)
  end
end
