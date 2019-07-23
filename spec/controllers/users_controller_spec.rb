require "rails_helper"

describe UsersController, type: :controller do
  describe 'GET show' do
    let(:user) { mock_model(User) }
    before { allow(User).to receive(:find_by).and_return(user) }

    it 'finds user by username' do
      expect(User).to receive(:find_by).with(username: 'the username').and_return(user)
      get :show, params: { username: 'the username' }
    end

    it 'returns success' do
      get :show, params: { username: 'real-user' }
      expect(response.status).to eq(200)
    end

    it 'returns error not found' do
      allow(User).to receive(:find_by).and_return(nil)
      get :show, params: { username: 'non-existant-user' }
      expect(response.status).to eq(404)
    end
  end

  describe 'GET new' do
    it 'renders a new User' do
      expect(User).to receive(:new)
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST create' do
    let(:user) { mock_model(User) }
    before { allow(User).to receive(:new).and_return(user) }

    it 'redirects if user saves successfully' do
      expect(user).to receive(:save).and_return(true)
      post :create,
        params: {
          user: {
            name:     'the name',
            username: 'the username'
          }
        }
      expect(response).to be_redirect
      expect(flash.notice).to eq('User was successfully created.')
    end
  end
end
