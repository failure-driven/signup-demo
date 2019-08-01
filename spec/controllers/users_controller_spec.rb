require 'rails_helper'

describe UsersController, type: :controller do
  describe 'GET show' do
    let(:user) { mock_model(User) }
    before { allow(User).to receive(:find_by).and_return(user) }

    it 'finds user by username' do
      expect(User).to receive(:find_by)
        .with(username: 'the username')
        .and_return(user)
      get :show, params: { username: 'the username' }
    end

    it 'returns success' do
      get :show, params: { email: 'email@example.com', username: 'hi' }
      expect(response.status).to eq(200)
    end

    it 'returns error' do
      allow(User).to receive(:find_by).and_return(nil)
      get :show, params: { username: 'hi' }
      expect(response.status).to eq(422)
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

    context 'fails to saves' do
      before { allow(user).to receive(:save).and_return(false) }

      it 'returns 422' do
        post :create, params: {
          user: {
            email: 'email@example.com',
            name: 'the name',
            username: 'the username'
          }
        }
        expect(response.status).to eq(422)
      end
    end

    context 'successfully saves' do
      before { allow(user).to receive(:save).and_return(true) }

      it 'redirects if user saves successfully' do
        expect(user).to receive(:save).and_return(true)
        post :create, params: {
          user: {
            email: 'email@example.com',
            name: 'the name',
            username: 'the username'
          }
        }
        expect(response).to be_redirect
        expect(flash.notice).to eq('User was successfully created.')
      end

      it 'passes the permitted parameters to user new' do
        user_params = {
          user: {
            email: 'email@example.com',
            name: 'the name',
            username: 'the username',
            ignored: 'i am ignored'
          }
        }
        permitted_params = ActionController::Parameters.new(
          user_params
        ).permit(:email, :name, :username)
        expect(
          User
        ).to receive(:new).with(permitted_params).and_return(user)
        post :create, params: { user: user_params }
        post :create, params: {
          user: {
            email: 'email@example.com',
            name: 'the name',
            username: 'the username',
            ignored: 'i am ignored'
          }
        }
      end
    end
  end
end
