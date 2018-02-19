module Cables
  class QuestionAnswersDomJob < ApplicationJob
    def perform(question)
      answers = question.answers.reload

      ActionCable.server.broadcast(
        "question:#{question.hash_id}:answers",
        html: render_answer(answers, question)
      )
    end

    private

    def render_answer(answers, question)
      ApplicationController.render(
        partial: 'questions/answers',
        locals: { answers: answers, question: question }
      )
    end
  end
end
