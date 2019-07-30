require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'username' do
    it 'is valid for alpha numeric characters' do
      username_all_valid_chars = [
        ('a'..'z').to_a |
          ('A'..'Z').to_a |
          (0..9).to_a, '_', '-'
      ].join
      # "abcdefghijklmnopqrstuvwxyz0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ_-"
      user = User.new(username: username_all_valid_chars)
      expect(user).to be_valid
    end

    context 'not valid' do
      " \t?|;.,/".chars.each do |character|
        it "is not valid with '#{character}' character" do
          user = User.new(username: "with-#{character}-character")
          expect(user).to_not be_valid
          expect(
            user.errors.messages
          ).to eq(username: ['can only have alphanumeric characters'])
        end
      end
    end
  end
end
