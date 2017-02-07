require 'bcrypt' # make sure 'bcrypt' is in your Gemfile
require 'dm-validations'

class User
  include DataMapper::Resource

  property :id, Serial
  property :email, String, :required => true, :unique => true,
    :format => :email_address,
    :messages => {
      :presence  => "We need your email address.",
      :is_unique => "We already have that email.",
      :format    => "Doesn't look like an email address to me ..."
    }

  property :password_digest, Text
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
    @password = password
  end

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password,
    :message => 'Password and confirmation password do not match'

    def self.authenticate(email, password)
      user = self.first(email: email)
      if user && BCrypt::Password.new(user.password_digest) == password
        user
      else
        nil
      end
    end
end
