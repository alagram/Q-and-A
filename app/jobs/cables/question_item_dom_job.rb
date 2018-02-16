module Cables
  class QuestionItemDomJob < ApplicationJob
    def perform(question)
      ActionCable.server.broadcast(
        "questions:#{question.id}",
        id: question.id,
        html: render_question(question)
      )
    end

    private

    def render_question(question)
      ApplicationController.render(
        partial: 'questions/question',
        locals: { question: question }
      )
    end
  end
end
