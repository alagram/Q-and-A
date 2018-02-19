module Cables
  class QuestionAnswersDomJob < ApplicationJob
    def perform(question)
      answers = question.answers.reload

      ActionCable.server.broadcast(
        "question:#{question.hash_id}:answers",
        html: render_answer(answers)
      )
    end

    private

    def render_answer(answers)
      ApplicationController.render(
        partial: 'questions/answers',
        locals: { answers: answers }
      )
    end
  end
end
