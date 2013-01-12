require 'bcrypt'
class User
  PASSWORD_SALT = "webmate"
  include Mongoid::Document

  field :email
  field :encrypted_password

  validates :email, presence: true
  validates :encrypted_password, presence: true, confirmation: true

  attr_reader :password

  def password=(password)
    @password = password
    self.encrypted_password = BCrypt::Password.create("#{password}#{PASSWORD_SALT}")
  end

  class << self
    def authenticate(email, password)
      user = where(email: email).first
      auth = BCrypt::Password.new(user.encrypted_password) == "#{password}#{PASSWORD_SALT}"
      auth ? user : nil
    end
  end
end