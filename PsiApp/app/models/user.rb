class User < ActiveRecord::Base
  attr_accessor :password, :password_confirmation

  before_validation :check_password_for_new_record

  NAME_MIN_LENGTH = 2
  LOGIN_WITHIN_LENGTH = 3..30

  NAME_REGEX = /\A[^[:cntrl:]\\<>\/&]*\z/
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  LOGIN_REGEX = /\A[a-z0-9_\-@\.]*\z/i

  SHIFT_WORKS = %w[integral morning afternoon]
  ROLES = %w[admin coordinator receptionist supervisor colleger]

  validates_presence_of :name, :shift_work, :email, :login, :role
  validates_presence_of :matriculation, if: :scholarship
  validates_format_of :name, with: NAME_REGEX
  validates_format_of :email, with: EMAIL_REGEX
  validates_format_of :login, with: LOGIN_REGEX
  validates_length_of :name, minimum: NAME_MIN_LENGTH
  validates_length_of :login, within: LOGIN_WITHIN_LENGTH
  validates_length_of :password, within: Psi::Authentication::PasswordManager::PASSWORD_WITHIN_LENGTH, allow_nil: true
  validates_confirmation_of :password, allow_nil: true
  validates_inclusion_of :scholarship, in: [true, false]
  validates_inclusion_of :active, in: [true, false]
  validates_inclusion_of :shift_work, in: SHIFT_WORKS
  validates_inclusion_of :role, in: ROLES
  validates_uniqueness_of :matriculation
  validates_uniqueness_of :email, case_sensitive: false
  validates_uniqueness_of :login, case_sensitive: false
  validates_uniqueness_of :reset_password_token

  def password=(arg)
    @password = arg
    if arg.blank?
      self.encrypted_password = self.password_salt = nil
    else
      self.password_salt ||= Psi::Authentication::Token.make
      self.encrypted_password = Psi::Authentication::PasswordManager.password_digest(arg, password_salt)
    end
  end

  def random_password!
    self.password = self.password_confirmation = Psi::Authentication::PasswordManager.random_password
  end

  private

  def check_password_for_new_record
    random_password! if new_record? && password.blank?
    true
  end
end