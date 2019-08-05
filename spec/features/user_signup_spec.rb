require 'rails_helper'

feature 'User signup', js: true do
  scenario 'User signs up successfully' do
    When 'Selena signs up with a valid username' do
      visit root_path
      fill_in('Email', with: 'selenawiththetattoo@gmail.com')
      fill_in('Username', with: 'selenawiththetattoo')
      click_on('Sign up')
    end

    Then 'her profile is shown' do
      wait_for { page.current_path }.to eq '/users/selenawiththetattoo'
      wait_for do
        page.find('#flash_messages')
      end.to have_text('User was successfully created.')
      wait_for { page.find('h4') }.to have_text('Your Profile')
      wait_for do
        p_strong_tags(page)
      end.to eq(
        'Email:' => 'selenawiththetattoo@gmail.com',
        'Username:' => 'selenawiththetattoo'
      )
      wait_for { page.find('a.btn') }.to have_text('Start App')
    end
  end
end

def p_strong_tags(page)
  page
    .find_all('p strong')
    .map do |p_element|
      strong_text = p_element.text
      [
        strong_text,
        p_element.find(:xpath, '..').text.sub(strong_text, '').strip
      ]
    end.to_h
end

def label_input_tags(page)
  page.document.synchronize do
    page
      .find_all('div[class="form-group"]')
      .map do |element|
      [
        find_field_in_element(element, 'label', :text),
        find_field_in_element(element, 'input', :value)
      ]
    end.to_h
  end
end

def find_field_in_element(element, field_name, value)
  element.find(field_name).send(value)
rescue StandardError
  "NO-#{field_name.upcase}-FOUND"
end
