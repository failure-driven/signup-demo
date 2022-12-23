class User < ApplicationRecord
  validate :validate_username
  validates :email, uniqueness: true
  validates :username, uniqueness: true

  private

  def validate_username
    return if /^[A-Za-z0-9_-]+$/.match?(username)

    errors.add(:username, "can only have alphanumeric characters")
  end
end
