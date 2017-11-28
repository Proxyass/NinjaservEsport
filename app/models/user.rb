class User < ApplicationRecord
  # Validation
  validates :firstname, :lastname, :mail, :password, :password_confirmation, :salt, presence: true
  validates :password, confirmation: true
  validates :password, :length => { minimum: 7 }
  validates :mail, uniqueness: true
  # -----

  # Hooks
  before_create :gen_token_and_salt
  before_save :set_lowercase
  # -----

  def set_lowercase
    self.firstname = self.firstname.downcase
    self.lastname = self.lastname.downcase
    self.mail = self.mail.downcase
  end

  def gen_token_and_salt
    self.gen_token
    self.gen_salt
  end

  def gen_token
    self.token = loop do
      token = SecureRandom.hex(12)
      break token unless User.exists?(token: token)
    end
  end

  def gen_salt
    self.salt = loop do
      salt = SecureRandom.hex(12)
      break salt unless User.exists?(salt: salt)
    end
  end

end
