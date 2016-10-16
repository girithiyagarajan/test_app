class User < ActiveRecord::Base
  has_many  :articles
  has_secure_password
  
  before_save {self.email = email.downcase}
  
  validates :username,presence: true, 
            length: {minimum: 3, maximum: 25}, 
            uniqueness: {case_sensitive: false}
  validates :email, presence: true, 
            length: {minimum:3, maximum: 105},
            uniqueness: {case_sensitive: false},
            format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password_digest, presence: true
  
end