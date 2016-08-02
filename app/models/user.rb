require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :questions
  has_many :answers_received, through: :questions, source: :answers
  has_many :answers_written, class_name: "Answer", foreign_key: "user_id"

  #Database validations (uniqueness and presence)
  validates :first_name, :presence => true 
  validates :last_name, :presence => true
  validates :email, :presence => true 
  validates :email, :uniqueness => true
  validates :password_digest, :presence => true

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
    if user && (user.password == user_password)
      return user
    else
      false
    end
  end
  
end
