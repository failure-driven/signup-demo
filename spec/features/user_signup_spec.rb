require 'rails_helper'

feature 'User signup', js: true do
  scenario 'User signs up successfully' do
    When 'Selena signs up with a valid username' do
      visit root_path
      signup_with(
          email:    'selenawiththetattoo@gmail.com',
          username: 'selenawiththetattoo'
      )
    end

    Then 'she is signed in' do
      wait_for do
        page.find('#flash_messages')
      end.to have_text('User was successfully created.')

      wait_for { page.find('h4') }.to have_text('Your Profile')

      wait_for { page.find('a.btn') }.to have_text('Start App')
    end
  end

  scenario 'User cannot sign up with an invalid username' do
    When 'Michael signs up with an invalid username' do
      visit root_path
      fill_in('Email', with: 'saramic@gmail.com')
      fill_in('Username', with: '50/50')
    end

    Then 'username is highlighted due to error' do
      wait_for do
        page.find('input[name="user[username]"]')[:class]
      end.to include('is-invalid')
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
      end.to include(
        'Email' => '',
        'Username' => ''
      )
    end
  end

  context 'A user with username "developer" exists' do
    before do
      User.create(email: 'email@example.com', username: 'developer')
    end

    scenario 'User cannot sign up with an existing username' do
      When "Michael signs up with username 'developer'" do
        visit root_path
        fill_in('Email', with: 'saramic@gmail.com')
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
        fill_in('Email', with: 'saramic@gmail.com')
        fill_in('Username', with: 'developer')
      end

      Then 'username is highlighted due to error' do
        wait_for do
          page.find('input[name="user[username]"]')[:class]
        end.to include('is-invalid')
      end
    end

    scenario 'User needs a uniq email' do
      When "Michael signs up with username 'developer'" do
        visit root_path
        fill_in('Email', with: 'email@example.com')
        fill_in('Username', with: 'some-username')
        click_on('Sign up')
      end

      Then 'an error is shown' do
        wait_for do
          page.find('#error_explanation').find_all('li').map(&:text)
        end.to eq(['Email has already been taken'])
      end
    end
  end
end

def signup_with(args)
  args.each{|(label,value)| fill_in(label.capitalize, with: value) }
  click_on('Sign up')
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
