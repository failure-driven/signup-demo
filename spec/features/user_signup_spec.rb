require "rails_helper"

feature "User signup", js: true do
  scenario "User signs up successfully" do
    When "Selena signs up with a valid username" do
      visit root_path
      focus_on(:signup).submit_with(
        email: "selenawiththetattoo@gmail.com",
        username: "selenawiththetattoo"
      )
    end

    Then "she is signed in" do
      wait_for do
        focus_on(:flash_messages).text
      end.to eq("User was successfully created.")

      wait_for { focus_on(:page_header).title }.to eq("Your Profile")

      wait_for { focus_on(:button).text }.to eq("Start App")
    end
  end

  scenario "User cannot sign up with an invalid username" do
    When "Michael signs up with an invalid username" do
      visit root_path
      focus_on(:signup).fill_in_with(
        email: "saramic@gmail.com",
        username: "50/50"
      )
    end

    Then "username is highlighted due to error" do
      wait_for do
        focus_on(:form).input_for("user[username]").class
      end.to include("is-invalid")
    end

    When "the user clicks signup anyway" do
      focus_on(:form).submit
    end

    Then "an error is shown" do
      wait_for do
        focus_on(:form).error_message
      end.to eq(["Username can only have alphanumeric characters"])
    end

    When "the user clicks home" do
      focus_on(:nav).go("Home")
    end

    Then "they are taken to the home url with empty fields" do
      wait_for { page.current_path }.to eq "/"
      wait_for do
        focus_on(:form).inputs
      end.to include(
        "Email" => "",
        "Username" => ""
      )
    end
  end

  context 'when A user with username "developer" exists' do
    before do
      User.create(email: "email@example.com", username: "developer")
    end

    scenario "User cannot sign up with an existing username" do
      When "Michael signs up with username 'developer'" do
        visit root_path
        focus_on(:signup).submit_with(
          email: "saramic@gmail.com",
          username: "developer"
        )
      end

      Then "an error is shown" do
        wait_for do
          focus_on(:form).error_message
        end.to eq(["Username has already been taken"])
      end
    end

    scenario 'User is shown an error
              whilst signing up with an existing username' do
      When 'Michael fills in sign up form
            with username developer' do
        visit root_path
        focus_on(:signup).fill_in_with(
          email: "saramic@gmail.com",
          username: "developer"
        )
      end

      Then "username is highlighted due to error" do
        wait_for do
          focus_on(:form).input_for("user[username]").class
        end.to include("is-invalid")
      end
    end

    scenario "User needs a uniq email" do
      When "Michael signs up with username 'developer'" do
        visit root_path
        focus_on(:signup).submit_with(
          email: "email@example.com",
          username: "some-username"
        )
      end

      Then "an error is shown" do
        wait_for do
          focus_on(:form).error_message
        end.to eq(["Email has already been taken"])
      end
    end
  end
end
