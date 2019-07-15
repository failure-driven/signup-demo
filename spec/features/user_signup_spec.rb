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

  scenario "A user with an invalid username" do
    When "Michael visits the site to sign up with his name and username '50/50'" do
      visit('/')
      fill_in('Name', with: 'Michael Milewski')
      fill_in('Username', with: '50/50')
      click_on("Sign up")
    end

    Then "He sees an error suggesting his handle is not valid with a '/' slash character" do
      wait_for {
        page.find('#error_explanation').find_all('li').map(&:text)
      }.to eq(["Username cannot have forward slash"])
    end
  end
end
