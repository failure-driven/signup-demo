require 'rails_helper'

feature 'User signup', js: true do
  scenario 'User signs up successfully' do
    When 'Selena signs up with a valid username' do
      visit root_path
      click_on('Sign up')
      focus_on(:signup).submit_with(
        email: 'selenawiththetattoo@gmail.com',
        username: 'selenawiththetattoo',
        password: 'password'
      )
    end

    Then 'she is signed in' do
      wait_for do
        focus_on(:flash_messages).text
      end.to eq('Welcome! You have signed up successfully.')

      wait_for { focus_on(:page_header).title }.to eq('Your Profile')

      wait_for { focus_on(:button).text }.to eq('Start App')
    end
  end

  context 'signup using omni auth' do
    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: '123456',
        info: {
          email: 'selenawiththetattoo@gmail.com'
        }
      )
      OmniAuth.config.mock_auth[:twitter] = OmniAuth::AuthHash.new(
        provider: 'twitter',
        uid: '123456',
        info: {
          email: 'selenasmall88@gmail.com',
          nickname: 'selenasmall88'
        }
      )
      OmniAuth.config.mock_auth[:github] = OmniAuth::AuthHash.new(
        provider: 'github',
        uid: '123456',
        info: {
          email: 'selenasmall@gmail.com'
        }
      )
      OmniAuth.config.mock_auth[:linkedin] = OmniAuth::AuthHash.new(
        provider: 'linkedin',
        uid: '123456',
        info: {
          email: 'in_selenasmall@gmail.com'
        }
      )
    end

    scenario 'User signs up with Facebook successfully' do
      When 'Selena signs up with a valid username' do
        visit root_path
        click_on('Sign up')
        click_on('Facebook')
      end

      Then 'her profile is shown' do
        wait_for { page.current_path }.to eq '/users/selenawiththetattoo'
        wait_for { focus_on(:page_header).title }.to eq('Your Profile')
        wait_for do
          focus_on(:profile).values
        end.to eq(
          'Email:' => 'selenawiththetattoo@gmail.com',
          'Username:' => 'selenawiththetattoo'
        )
      end
    end

    scenario 'User signs up with Twitter successfully' do
      When 'Selena signs up with a valid username' do
        visit root_path
        click_on('Sign up')
        click_on('Twitter')
      end

      Then 'her profile is shown' do
        wait_for { page.current_path }.to eq '/users/selenasmall88'
        wait_for { focus_on(:page_header).title }.to eq('Your Profile')
        wait_for do
          focus_on(:profile).values
        end.to eq(
          'Email:' => 'selenasmall88@gmail.com',
          'Username:' => 'selenasmall88'
        )
      end
    end

    scenario 'User signs up with GitHub successfully' do
      When 'Selena signs up with a valid username' do
        visit root_path
        click_on('Sign up')
        click_on('GitHub')
      end

      Then 'her profile is shown' do
        wait_for { page.current_path }.to eq '/users/selenasmall'
        wait_for { focus_on(:page_header).title }.to eq('Your Profile')
        wait_for do
          focus_on(:profile).values
        end.to eq(
          'Email:' => 'selenasmall@gmail.com',
          'Username:' => 'selenasmall'
        )
      end
    end

    scenario 'User signs up with LinkedIn successfully' do
      When 'Selena signs up with a valid username' do
        visit root_path
        click_on('Sign up')
        click_on('LinkedIn')
      end

      Then 'her profile is shown' do
        wait_for { page.current_path }.to eq '/users/in_selenasmall'
        wait_for { focus_on(:page_header).title }.to eq('Your Profile')
        wait_for do
          focus_on(:profile).values
        end.to eq(
          'Email:' => 'in_selenasmall@gmail.com',
          'Username:' => 'in_selenasmall'
        )
      end
    end
  end

  scenario 'User cannot sign up with an invalid username' do
    When 'Michael signs up with an invalid username' do
      visit root_path
      click_on('Sign up')
      focus_on(:signup).fill_in_with(
        email: 'saramic@gmail.com',
        username: '50/50',
        password: 'password'
      )
    end

    Then 'username is highlighted due to error' do
      wait_for do
        focus_on(:form).input_for('user[username]').class
      end.to include('is-invalid')
    end

    When 'the user clicks signup anyway' do
      focus_on(:form).submit
    end

    Then 'an error is shown' do
      wait_for do
        focus_on(:form).error_message
      end.to eq(['Username can only have alphanumeric characters'])
    end

    When 'the user clicks home' do
      focus_on(:nav).go('Home')
    end

    Then 'they are taken to the home url with empty fields' do
      wait_for { page.current_path }.to eq '/users/sign_in'
      wait_for do
        focus_on(:form).inputs
      end.to include(
        'Email' => ''
      )
    end
  end

  context 'A user with username "developer" exists' do
    before do
      User.create!(
        email: 'email@example.com',
        username: 'developer',
        password: 'password'
      )
    end

    scenario 'User cannot sign up with an existing username' do
      When "Michael signs up with username 'developer'" do
        visit root_path
        click_on('Sign up')
        focus_on(:signup).submit_with(
          email: 'saramic@gmail.com',
          username: 'developer',
          password: 'password'
        )
      end

      Then 'an error is shown' do
        wait_for do
          focus_on(:form).error_message
        end.to eq(['Username has already been taken'])
      end
    end

    scenario 'User is shown an error
              whilst signing up with an existing username' do
      When 'Michael fills in sign up form
            with username developer' do
        visit root_path
        click_on('Sign up')
        focus_on(:signup).fill_in_with(
          email: 'saramic@gmail.com',
          username: 'developer',
          password: 'password'
        )
      end

      Then 'username is highlighted due to error' do
        wait_for do
          focus_on(:form).input_for('user[username]').class
        end.to include('is-invalid')
      end
    end

    scenario 'User needs a uniq email' do
      When "Michael signs up with username 'developer'" do
        visit root_path
        click_on('Sign up')
        focus_on(:signup).submit_with(
          email: 'email@example.com',
          username: 'some-username',
          password: 'password'
        )
      end

      Then 'an error is shown' do
        wait_for do
          focus_on(:form).error_message
        end.to eq(['Email has already been taken'])
      end
    end
  end
end
