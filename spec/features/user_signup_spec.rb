require 'rails_helper'

feature 'User signup', js: true do
  before {
    page.driver.browser.manage.window.resize_to(767, 768)
  }
  scenario 'User signs up successfully' do
    When 'Selena signs up with a valid username' do
      visit root_path
      focus_on(:signup).submit_with(
          email:    'selenawiththetattoo@gmail.com',
          username: 'selenawiththetattoo'
      )
    end

    Then 'she is signed in' do
      wait_for do
        focus_on(:flash_messages).text
      end.to eq('User was successfully created.')

      wait_for { focus_on(:page_header).title }.to eq('Your Profile')

      wait_for { focus_on(:button).text }.to eq('Start App')
      sleep(2)
    end
  end
end
