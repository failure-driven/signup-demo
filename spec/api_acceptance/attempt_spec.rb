require "rails_helper"

RSpec.describe "Attempt", type: :request do
  describe "GET /attempt" do
    it "responds with success" do
      get "/api/attempt?username=username1",
        headers: {
          Accept: "application/json"
        }
      expect(response).to have_http_status(:ok)
    end

    it "responds with no errors for successful attempt for username" do
      get "/api/attempt?username=user_attempt_1",
        headers: {
          Accept: "application/json"
        }
      expect(JSON.parse(response.body)).to eq(
        "username" => "user_attempt_1"
      )
    end

    it "responds with no error for a blank username" do
      get "/api/attempt?username=",
        headers: {
          Accept: "application/json"
        }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(
        "username" => ""
      )
    end

    context "when user with blank email and username exists" do
      before do
        User.create!(email: "", username: "a")
      end

      it "responds with no error for a valid username" do
        get "/api/attempt?username=valid-username",
          headers: {
            Accept: "application/json"
          }
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to eq(
          "username" => "valid-username"
        )
      end
    end

    context "when user_1 exists" do
      before do
        User.create(email: "email@example.com", username: "user_1")
      end

      it 'responds with errors and suggestions
          for a username that is taken' do
        get "/api/attempt?username=user_1",
          headers: {
            Accept: "application/json"
          }
        expect(JSON.parse(response.body)).to eq(
          "errors" => {
            "messages" => {
              "username" => ["has already been taken"]
            }
          },
          "username" => "user_1",
          "username_suggestions" => [
            {"username" => "user_11"},
            {"username" => "user_12"},
            {"username" => "user_13"},
            {"username" => "user_14"},
            {"username" => "user_15"},
            {"username" => "user_16"},
            {"username" => "user_17"},
            {"username" => "user_18"},
            {"username" => "user_19"}
          ]
        )
      end
    end
  end
end
