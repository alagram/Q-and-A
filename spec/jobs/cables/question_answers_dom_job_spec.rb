require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe Cables::QuestionAnswersDomJob do
  before do
    @user = FactoryBot.create(:user)
    @question = FactoryBot.create(
      :question,
      user: @user,
      title: "Test Title",
      body: "Test body"
    )
    @answer = FactoryBot.create(
      :answer,
      body: 'Test Answer',
      user: FactoryBot.create(:user)
    )
  end

  it 'matches with enqueued job' do
    ActiveJob::Base.queue_adapter = :test
    Cables::QuestionAnswersDomJob.perform_later
    expect(Cables::QuestionAnswersDomJob).to have_been_enqueued
  end

  it 'enqueues a default based job' do
    ActiveJob::Base.queue_adapter = :test
    expect { Cables::QuestionAnswersDomJob.perform_later(@question) }.to have_enqueued_job.on_queue('default')
  end

  it 'renders a partial' do
    expect(ApplicationController).to receive(:render)
    Cables::QuestionAnswersDomJob.perform_now(@question)
  end
end
