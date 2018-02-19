require 'rails_helper'

RSpec.feature 'ActionCable Update Question Answers Feed', type: :feature do
  login_user

  before do
    @question = FactoryBot.create(
      :question,
      user: @user,
      title: "Test Title",
      body: "Test body"
    )
  end

  it "should see new answer via ActionCable", js: true, puma: true do
    visit question_path(@question)

    answer_text = "Oh yeah!"

    expect(page).not_to have_content(answer_text)

    new_window = open_new_window

    within_window new_window do
      visit question_path(@question)
      # save_and_open_page
      find('textarea', match: :first).set answer_text
      click_on 'submit answer'

      expect(page).to have_content(answer_text)
    end

    expect do
      switch_to_window(windows.first)
      page.to have_text(answer_text)
    end

    visit root_path

  end
end
