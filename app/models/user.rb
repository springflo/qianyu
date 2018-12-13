class User < ActiveRecord::Base
    has_many :posts
    validates :email, length:{maximum:40}, presence: true
    validates :username, length:{maximum:40}, presence: true
end
