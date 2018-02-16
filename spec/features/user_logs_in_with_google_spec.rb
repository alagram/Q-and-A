require 'rails_helper'

RSpec.feature "user logs in" do
  background do
    visit root_path

    OmniAuth.config.test_mode = true
  end

  scenario "using valid credentials" do
    OmniAuth.config.add_mock(:google_oauth2, {uid: '987654', info: {email: 'test@example.com'}, credentials: {token: '12345'}})

    click_link "Sign in with Google"

    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Log Out")
  end

  scenario "with invalid credentials" do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials

    click_link "Sign in with Google"

    expect(page).to_not have_content("Signed in successfully.")
    expect(page).to_not have_content("Log Out")
  end
end
