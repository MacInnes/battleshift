require 'securerandom'

class User < ApplicationRecord
  validates_presence_of :name, :email
  validates_presence_of :password, :password_confirmation, on: :create

  has_secure_password

  enum status: [:inactive, :active]

  def generate_api_key
    update(api_key: SecureRandom.urlsafe_base64) unless api_key
  end

  def activate_account
    update(status: 1)
  end
end
