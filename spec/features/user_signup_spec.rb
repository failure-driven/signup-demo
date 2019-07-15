require 'rails_helper'

feature 'User signup', js: true do
  scenario "A user with a valid username" do
    When "Selena visits the site to sign up with her name and username 'selenawiththetattoo'" do
      visit('/')
      fill_in('Name', with: 'Selena Small')
      fill_in('Username', with: 'selenawiththetattoo')
      click_on("Sign up")
    end

    Then "She sees here unique url /users/selenawiththetattoo" do
      wait_for { page.current_path }.to eq "/users/selenawiththetattoo"
    end
  end
end
