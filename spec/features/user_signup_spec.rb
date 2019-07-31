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
  end

  context 'A user with username "developer" exists' do
    before do
      User.create(username: 'saramic')
    end

    scenario 'User cannot sign up with an existing username' do
      When "Michael signs up with username 'developer'" do
        visit root_path
        fill_in('Name', with: 'Michael Milewski')
        fill_in('Username', with: 'saramic')
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
      When 'Michael fills in signs up form
            with username saramic' do
        visit root_path
        fill_in('Name', with: 'Michael Milewski')
        fill_in('Username', with: 'saramic')
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
