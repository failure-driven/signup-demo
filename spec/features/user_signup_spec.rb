require 'rails_helper'

feature 'User signup', js: true do
  scenario "User signs up successfully" do
    When "Selena signs up with a valid username" do
      visit root_path
      fill_in('Email', with: 'selenawiththetattoo@gmail.com')
      fill_in('Username', with: 'selenawiththetattoo')
      click_on("Sign up")
    end

    Then "her profile is shown" do
      # TODO change for H1 to be my profile
      # TODO Welcome handle
      # TODO success message
      wait_for { page.current_path }.to eq "/users/selenawiththetattoo"
    end
  end

  # User cannot sign up with an invalid username
  # A user with username "developer" exists
end
