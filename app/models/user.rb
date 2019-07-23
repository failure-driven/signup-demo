class User < ApplicationRecord
  validate :validate_username
  validates :username, uniqueness: true

  private

  def validate_username
    if !username.match(/^[A-Za-z0-9_-]+$/)
      errors.add(:username, "can only have alphanumeric characters")
    end
  end
end
