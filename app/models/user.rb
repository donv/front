# frozen_string_literal: true

require 'digest/sha1'

class User < ApplicationRecord
  # Virtual attribute for the unencrypted password
  attr_accessor :password

  validates :login, :email, presence: true
  validates :password, presence: { if: :password_required? }
  validates :password_confirmation, presence: { if: :password_required? }
  validates :password, length: { within: 4..40, if: :password_required? }
  validates :password, confirmation: { if: :password_required? }
  validates :login, length: { within: 3..40 }
  validates :email, length: { within: 3..100 }
  validates :login, :email, uniqueness: { case_sensitive: false }
  before_save :encrypt_password

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(login, password)
    u = find_by(login: login) # need to get the salt
    u&.authenticated?(password) ? u : nil
  end

  # Encrypts some data with the salt.
  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end

  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end

  def authenticated?(password)
    crypted_password == encrypt(password)
  end

  def remember_token?
    remember_token_expires_at && Time.now.utc < remember_token_expires_at
  end

  # These create and unset the fields required for remembering users between browser closes
  def remember_me
    self.remember_token_expires_at = 2.weeks.from_now.utc
    self.remember_token = encrypt("#{email}--#{remember_token_expires_at}")
    save(validate: false)
  end

  def forget_me
    self.remember_token_expires_at = nil
    self.remember_token = nil
    save(validate: false)
  end

  protected

  # before filter
  def encrypt_password
    return if password.blank?

    self.salt = Digest::SHA1.hexdigest("--#{Time.zone.now}--#{login}--") if new_record?
    self.crypted_password = encrypt(password)
  end

  def password_required?
    crypted_password.blank? || password.present?
  end
end
