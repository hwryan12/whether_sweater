class User < ApplicationRecord
  before_create :create_api_key

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true
  validates :password_confirmation, presence: true

  private

  def create_api_key
    self.api_key = SecureRandom.hex(16)
  end
end
