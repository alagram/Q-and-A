module CableServices
  class NotifyJobsService

    def initialize(question)
      @question = question
    end

    def self.call(params)
      new(params).send(:perform)
    end

    private

    attr_reader :question

    def perform
      Cables::QuestionAnswersDomJob.perform_later(question)
    end
  end
end
