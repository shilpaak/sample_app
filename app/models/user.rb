class User < ActiveRecord::Base
  before_save { self.email=email.downcase }
  validates :name, presence: true, length: {maximum: 50}
  #validates(:email,  presence:true)
  VALID_EMAIL_REGEXP=/\A[\w+\-.]+@[a-z\d\.]+\.[a-z]+\z/i
  validates(:email, format: {with: VALID_EMAIL_REGEXP}, uniqueness: {case_sensitive: false})
  has_secure_password
  validates :password, length: {minimum: 6}
  before_create { create_remember_token }
  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end
  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end
  private
  def create_remember_token
    self.remember_token=Digest::SHA1.hexdigest(User.new_remember_token)
  end
end
