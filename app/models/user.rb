class User < ApplicationRecord
  validate :validate_username
  validates :username, uniqueness: true

  private

  def validate_username
    [
      { character: ' ',  name: 'white space'},
      { character: "\t", name: 'white space'},
      { character: '?',  name: 'question mark'},
      { character: '/',  name: 'forward slash'},
    ].each do |character|
      if username.index(character[:character])
        errors.add(:username, "cannot have #{character[:name]}")
      end
    end
  end
end
