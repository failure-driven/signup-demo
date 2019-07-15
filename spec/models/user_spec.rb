require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'username' do
    it 'is valid for alpha numeric characters' do
      user = User.new(username: 'abc123')
      expect(user).to be_valid
    end
  end
end
