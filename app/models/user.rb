class User < ApplicationRecord
  validate :validate_username

  private

  def validate_username
    [
      { character: ' ',  name: 'white space'},
      { character: "\t", name: 'white space'},
      { character: '?',  name: 'question mark'},
    ].each do |character|
      if username.index(character[:character])
        errors.add(:username, "cannot have #{character[:name]}")
      end
    end
  end
end
