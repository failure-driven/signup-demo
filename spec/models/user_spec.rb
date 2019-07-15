require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'username' do
    it 'is valid for alpha numeric characters' do
      user = User.new(username: 'abc123')
      expect(user).to be_valid
    end

    context 'not valid characters' do
      it 'is not valid with SPACE' do
        user = User.new(username: 'with space')
        expect(user).to_not be_valid
        expect(user.errors.messages).to eq(username: ["cannot have white space"])
      end

      it 'is not valid with TAB' do
        user = User.new(username: "with\ttab")
        expect(user).to_not be_valid
        expect(user.errors.messages).to eq(username: ["cannot have white space"])
      end
    end
  end
end
