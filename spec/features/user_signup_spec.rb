require 'rails_helper'

feature 'User signup', js: true do
  scenario "User signs up successfully" do
    When "Selena signs up with a valid username" do
      visit root_path
      fill_in('Name', with: 'Selena Small')
      fill_in('Username', with: 'selenawiththetattoo')
      click_on("Sign up")
    end

    Then "her profile is shown" do
      # TODO change for H1 to be my profile
      # TODO Welcome handle
      wait_for { page.current_path }.to eq "/users/selenawiththetattoo"
    end
  end

  #  User cannot sign up with an invalid username
  scenario "User cannot sign up with an invalid username" do
    When "Michael signs up with an invalid username" do
      visit('/')
      fill_in('Name', with: 'Michael Milewski')
      fill_in('Username', with: '50/50')
    end

    Then 'username is highlighted due to error' do
      wait_for {
        page.find('input[name="user[username]"]')[:class]
      }.to include("field_with_errors")
    end

    When "the user clicks signup anyway" do
      click_on("Sign up")
    end

    Then "an error is shown" do
      wait_for {
        page.find('#error_explanation').find_all('li').map(&:text)
      }.to eq(["Username can only have alphanumeric characters"])
    end
  end

  # A user with username "developer" exists
  context 'A user with username "developer" exists' do
    before do
      User.create(username: "developer")
    end

    scenario "User cannot sign up with an existing username" do
      When "Michael signs up with username 'developer'" do
        visit('/')
        fill_in('Name', with: 'Michael Milewski')
        fill_in('Username', with: 'developer')
        click_on("Sign up") # change and new error
      end

      Then "an error is shown" do
        wait_for {
          page.find('#error_explanation').find_all('li').map(&:text)
        }.to eq(["Username has already been taken"])
      end
    end
  end
end
