require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :questions
  has_many :answers_received, through: :questions, source: :answers
  has_many :answers_written, class_name: "Answer", foreign_key: "user_id"

  #Database validations (uniqueness and presence)
  validates :first_name,  presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false }
  validates :password_digest, presence: true, length: { minimum: 6 }

  #Both methods are needed for BCrypt to work.
  def password
    @password ||= Password.new(password_digest)
  end

  def password=(user_password)
    @password = Password.create(user_password)
    self.password_digest = @password
  end
  
  #This is the authentication method of BCrypt (== works differently than in Ruby)
  def self.authenticate(email, user_password)
    user = User.find_by(email: email)
    if user && (user.password_digest == user_password)
      return user
    else
      false
    end
  end
  
end
