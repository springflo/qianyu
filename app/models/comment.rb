class Comment < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :user
  belongs_to :post
  validates :content, presence: true
  validates :post_id, :user_id, presence: true
  has_many :replies, dependent: :destroy
  
  #通过评论实例获取该评论客户的用户名
  def get_user
    @user = User.find_by(id: self.user_id)
  end
  
  
end
