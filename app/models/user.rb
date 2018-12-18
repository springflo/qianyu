class User < ActiveRecord::Base
    attr_accessor :remember_token, :activation_token
    
    has_many :posts
    
     # before_save {self.email = email.downcase }
    before_save :downcase_email
    before_create :create_activation_digest
   
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, length:{maximum:40}, presence: true,
                format: {with: VALID_EMAIL_REGEX}, 
                uniqueness: {case_sensitive:false}
                
    validates :username, length:{maximum:40}, presence: true
    
    has_secure_password
    validates :password, length: {minimum: 6}, presence: true, allow_nil: true
    
    
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
    # def authenticated?(remember_token)
    #     return false if remember_digest.nil?
    #     BCrypt::Password.new(remember_digest).is_password?(remember_token)
    # end
    def authenticated?(attribute, token)
        digest = send("#{attribute}_digest")
        return false if digest.nil?
        BCrypt::Password.new(digest).is_password?(token)
    end
    
    
    # 忘记用户
    def forget
        update_attribute(:remember_digest, nil)
    end
    
    
    
    # 激活账号
    def activate
      update_attribute(:activated, true)
      update_attribute(:activated_at, Time.zone.now)
    end
    
    # 发送激活邮件
    def send_activation_email
      UserMailer.account_activation(self).deliver_now
    end
    
    
    
    
    private
      
      # 电子邮件地址转换为小写
      def downcase_email
          self.email = email.downcase
      end
      
      # 创建并赋值激活令牌和摘要
      def create_activation_digest
          self.activation_token = User.new_token
          self.activation_digest = User.digest(activation_digest)
      end
     
    
    
end
