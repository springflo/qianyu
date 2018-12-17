class User < ActiveRecord::Base
    attr_accessor :remember_token
    
    has_many :posts
    before_save {self.email = email.downcase }
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, length:{maximum:40}, presence: true,
                format: {with: VALID_EMAIL_REGEX}, 
                uniqueness: {case_sensitive:false}
                
    validates :username, length:{maximum:40}, presence: true
    
    has_secure_password
    validates :password, length: {minimum: 6}, presence: true
    
    
    # 返回指定字符串的哈希摘要
    def User.digest(string)
        cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                            BCrypt::Engine.cost
        BCrypt::Password.create(string, cost: cost)
    end
    
    # 返回一个随机令牌
    def User.new_token
        SecureRandom.urlsafe_base64
    end
    
    # 为了持保存会话，在数据库中记住用户
    def remember
        self.remember_token = User.new_token
        update_attribute(:remember_digest, User.digest(remember_token))
    end
    
    # 如果指定的令牌和摘要匹配，返回true
    def authenticated?(remember_token)
        return false if remember_digest.nil?
        BCrypt::Password.new(remember_digest).is_password?(remember_token)
    end
    
    # 忘记用户
    def forget
        update_attribute(:remember_digest, nil)
    end
    
end
