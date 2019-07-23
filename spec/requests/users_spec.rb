require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /" do
    it "users sign up page by default" do
      get root_path
      expect(response).to have_http_status(200)
    end
  end

  context 'user exists' do
    before do
      user = User.create!(email: 'developer@example.com', username: 'developer')
    end

    describe "GET /users/developer" do
      it "fetches a user" do
        get user_path(username: 'developer')
        expect(response).to have_http_status(200)
      end
    end

    describe "GET /users/NOT_developer" do
      it "fails to fetch a user" do
        get user_path(username: 'NOT_developer')
        expect(response).to have_http_status(404)
      end
    end
  end
end
