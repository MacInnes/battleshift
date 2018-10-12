require 'securerandom'

class User < ApplicationRecord
  validates_presence_of :name, :email, :password, :password_confirmation

  has_secure_password

  enum status: [:inactive, :active]

  def generate_api_key
    self.api_key = SecureRandom.urlsafe_base64 unless api_key
  end
end
