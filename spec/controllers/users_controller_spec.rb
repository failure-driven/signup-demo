require "rails_helper"

describe UsersController, type: :controller do
  describe 'GET show' do
    it 'shows a user' do
      pending 'how to hit custom action show?'
      get :show
      expect(response.status).to eq(200)
      expect(response.body).to eq('body')
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
    let(:user_params) { {name: 'the name', username: 'the username', other: 'ignored'} }
    let(:permitted_params) do
      params_to_model = ActionController::Parameters.new(
        user_params
      ).permit(:name, :username)
    end

    it 'user fails to save' do
      user = mock_model(User)
      expect(User).to receive(:new).with(permitted_params).and_return(user)
      expect(user).to receive(:save).and_return(false)
      post :create, params: {user: user_params}
      expect(response.status).to eq(200)
    end

    it 'user saves' do
      user = mock_model(User)
      expect(User).to receive(:new).with(permitted_params).and_return(user)
      expect(user).to receive(:save).and_return(true)
      post :create, params: {user: user_params}
      expect(response.status).to eq(302)
    end
  end
end
