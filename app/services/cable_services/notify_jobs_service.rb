module CableServices
  class NotifyJobsService
    attr_reader :question, :action, :user

    def initialize(params)
      @question = params[:question]
      @action = params[:action]
      @user = params[:user]
    end

    def self.call(params)
      new(params).send(:perform)
    end

    private

    def perform
      if action == :update
        Cables::QuestionItemDomJob.perform_later(question)
      end
    end
  end
end
