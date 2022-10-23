# frozen_string_literal: true

class User < ApplicationRecord
  attr_reader :password

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6 }, allow_nil: true
  validates :session_token, presence: true, uniqueness: true

  def self.find_by_credentials(username:, password:)
    user = User.find_by(username:)
    return nil if user.nil?

    user.is_password?(password) ? user : nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end
end
