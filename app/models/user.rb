class User < ApplicationRecord
  validate :validate_username
  validates :username, uniqueness: true

  VALID_CHARACTERS = [('a'..'z').to_a | ('A'..'Z').to_a | (0..9).to_a, '_', '-'].join.chars.freeze

  private

  def validate_username
    username.chars.sort.uniq.each do |username_character|
      unless VALID_CHARACTERS.include?(username_character)
        errors.add(:username, "can only have alphanumeric characters underscore '_' and hyphen '-'")
        break
      end
    end
  end
end
