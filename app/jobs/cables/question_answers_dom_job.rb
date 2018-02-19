module Cables
  class QuestionAnswersDomJob < ApplicationJob
    def perform(question, current_user_id)
      current_user = User.find_by(id: current_user_id)
      answers = question.answers.reload

      ActionCable.server.broadcast(
        "question:#{question.hash_id}:answers",
        html: render_answer(answers, question, current_user)
      )
    end

    private

    def render_answer(answers, question, current_user)
      ApplicationController.render(
        partial: 'questions/answers',
        locals: { answers: answers,
                  question: question,
                  current_user: current_user }
      )
    end
  end
end
