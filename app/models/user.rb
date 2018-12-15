class User < ActiveRecord::Base
    has_many :posts
    before_save {self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, length:{maximum:40}, presence: true,
                format: {with: VALID_EMAIL_REGEX}, 
                uniqueness: {case_sensitive:false}
                
    validates :username, length:{maximum:40}, presence: true
    
    has_secure_password
    validates :password, length: {minimum: 6}, presence: true
    
end
