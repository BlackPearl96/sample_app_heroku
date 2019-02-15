class User < ApplicationRecord
  before_save{email.downcase!}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name,  presence: true, length:
    {maximum: Settings.user.name.max_length}
  validates :email, presence: true, length:
    {maximum: Settings.user.email.max_length},
  format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length:
    {minimum: Settings.user.password.min_length}
  has_secure_password

  # attribute :name
  # attribute :email
  # attribute :password

  # attr_accessor :name, :email, :password

  # validates_presence_of :name
  # validates_length_of :name, :maximum => Settings.user.name.max_length
  # validates_format_of :email, :with => /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  # validates_length_of :email, :maximum => Settings.user.email.max_length
  # validates :password, :presence => true
  # validates_length_of :password, :minimum => Settings.user.password.min_length
  # has_secure_password
end
