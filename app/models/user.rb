class User < ActiveRecord::Base
    attr_accessor :remember_token, :activation_token, :reset_token
    
    has_many :posts, dependent: :destroy
    has_many :active_relationships, class_name: "Relationship",
                                    foreign_key: "follower_id",
                                    dependent: :destroy
    has_many :passive_relationships, class_name: "Relationship",
                                    foreign_key: "followed_id",
                                    dependent: :destroy
    has_many :following, through: :active_relationships, source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    
    
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
    
    # 设置密码重设相关属性
    def create_reset_digest
        self.reset_token = User.new_token
        update_attribute(:reset_digest, User.digest(reset_token))
        update_attribute(:reset_send_at, Time.zone.now)
    end
    
    # 发送密码重设邮件
    def send_password_reset_email
        UserMailer.password_reset(self).deliver_now
    end
    
    # 如果修改密码请求超时了，返回ture
    def password_reset_expired?
        reset_sent_at < 2.hours.ago
    end
    
    
    # 实现动态流原型
    def feed
        # id 转义，避免SQL注入攻击
        # Post.where("user_id = ?", id)
        following_ids = "SELECT followed_id FROM relationships
                        WHERE follower_id = :user_id"
        Post.where("user_id IN (#{following_ids}) OR user_id = :user_id", 
                    user_id: id)
    end
    
    # 关注另一用户
    def follow(other_user)
        following << other_user
    end
    
    # 取消关注另一用户
    def unfollow(other_user)
        following.delete(other_user)
    end
    
    # 如果当前用户关注了指定用户，返回true
    def following?(other_user)
        following.include?(other_user)
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
