require 'rails_helper'

describe Api::UsernamesController, type: :controller do
  describe 'GET attempt' do
    it 'for unique username' do
      mock_user = double('User', valid?: true, username: 'the username')
      expect(
        User
      ).to receive(:new)
        .with(username: 'the username')
        .and_return(mock_user)
      @request.headers['Accept'] = 'application/json'
      get :attempt, params: { username: 'the username' }
      expect(response.status).to eq(200)
      expect(response.body).to eq('{"username":"the username"}')
    end

    it 'for a blank username' do
      @request.headers['Accept'] = 'application/json'
      get :attempt, params: { username: '' }
      expect(response.status).to eq(200)
      expect(response.body).to eq('{"username":""}')
    end

    it 'for NOT unique username' do
      mock_user = double('User',
                         valid?: false,
                         username: 'the username',
                         errors: double('Errors', messages: ['error 1']))
      expect(
        User
      ).to receive(:new).with(username: nil).and_return(mock_user)
      @request.headers['Accept'] = 'application/json'
      get :attempt
      expect(response.status).to eq(200)
      expect(response.body).to eq(
        '{"username":"the username",' \
        '"errors":{"messages":["error 1"]},' \
        '"username_suggestions":[' \
          '{"username":"1"},{"username":"2"},{"username":"3"},' \
          '{"username":"4"},{"username":"5"},{"username":"6"},' \
          '{"username":"7"},{"username":"8"},{"username":"9"}' \
        ']}'
      )
    end
  end
end
