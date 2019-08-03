require 'rails_helper'

RSpec.describe 'Users', type: :request do
  describe 'GET /' do
    it 'responds with success' do
      get '/'
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /users/:username' do
    it 'returns unprocessable for a username not found' do
      get '/users/non-existent-username'
      expect(response).to have_http_status(422)
    end

    context 'my-username exists' do
      before do
        User.create(email: 'email@example.com', username: 'my-username')
      end

      it 'returns success for fetching an existing user' do
        get '/users/my-username'
        expect(response).to have_http_status(200)
      end
    end
  end

  describe 'POST /users' do
    it 'redirects on successful create' do
      post '/users', params: {
        user: {
          email: 'email@example.com', username: 'valid-username'
        }
      }
      expect(response).to have_http_status(302)
      expect(response.headers.to_hash['Location']).to eq('http://www.example.com/users/valid-username')
    end

    it 'returns unprocessable with invalid username blank' do
      post '/users', params: { user: { username: '' } }
      expect(response).to have_http_status(422)
    end

    it 'returns unprocessable with invalid username with spaces' do
      post '/users', params: { user: { username: 'space is not valid' } }
      expect(response).to have_http_status(422)
    end
  end

  describe 'GET /users' do
    it 'redirects to new' do
      get '/users'
      expect(response).to have_http_status(301)
      expect(response.headers.to_hash['Location']).to eq('http://www.example.com/')
    end
  end
end
