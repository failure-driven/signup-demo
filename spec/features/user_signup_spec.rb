require 'rails_helper'

feature 'User signup', js: true do
  scenario 'User signs up successfully' do
    When 'Selena signs up with a valid username' do
      visit root_path
      fill_in('Name', with: 'Selena Small')
      fill_in('Username', with: 'selenawiththetattoo')
      click_on('Sign up')
    end

    Then 'her profile is shown' do
      wait_for { page.current_path }.to eq '/users/selenawiththetattoo'
      wait_for { page.find('h1') }.to have_text('Your Profile')
      wait_for do
        p_strong_tags(page)
      end.to eq(
        'Name:' => 'Selena Small',
        'Username:' => 'selenawiththetattoo'
      )
    end
  end

  scenario 'User cannot sign up with an invalid username' do
    When 'Michael signs up with an invalid username' do
      visit root_path
      fill_in('Name', with: 'Michael Milewski')
      fill_in('Username', with: '50/50')
    end

    Then 'username is highlighted due to error' do
      wait_for do
        page.find('input[name="user[username]"]')[:class]
      end.to include('field_with_errors')
    end

    When 'the user clicks signup anyway' do
      click_on('Sign up')
    end

    Then 'an error is shown' do
      wait_for do
        page.find('#error_explanation').find_all('li').map(&:text)
      end.to eq(['Username can only have alphanumeric characters'])
    end

    When 'the user clicks home' do
      click_on('Home')
    end

    Then 'they are taken to the home url with empty fields' do
      wait_for { page.current_path }.to eq '/'
      wait_for do
        label_input_tags(page)
      end.to eq(
        'Name' => '',
        'Username' => 'NO-INPUT-FOUND'
      )
    end
  end

  context 'A user with username "developer" exists' do
    before do
      User.create(username: 'developer')
    end

    scenario 'User cannot sign up with an existing username' do
      When "Michael signs up with username 'developer'" do
        visit root_path
        fill_in('Name', with: 'Michael Milewski')
        fill_in('Username', with: 'developer')
        click_on('Sign up')
      end

      Then 'an error is shown' do
        wait_for do
          page.find('#error_explanation').find_all('li').map(&:text)
        end.to eq(['Username has already been taken'])
      end
    end

    scenario 'User is shown an error
              whilst signing up with an existing username' do
      When 'Michael fills in sign up form
            with username developer' do
        visit root_path
        fill_in('Name', with: 'Michael Milewski')
        fill_in('Username', with: 'developer')
      end

      Then 'username is highlighted due to error' do
        wait_for do
          page.find('input[name="user[username]"]')[:class]
        end.to include('field_with_errors')
      end
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
      .find_all('div[class="field"]')
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
