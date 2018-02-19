module CableServices
  class NotifyJobsService

    def initialize(params)
      @question = params[:question]
      @current_user_id = params[:current_user_id]
    end

    def self.call(params)
      new(params).send(:perform)
    end

    private

    attr_reader :question, :current_user_id

    def perform
      Cables::QuestionAnswersDomJob.perform_later(question, current_user_id)
    end
  end
end
