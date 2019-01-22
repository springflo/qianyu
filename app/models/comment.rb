class Comment < ActiveRecord::Base
  include ApplicationHelper
  
  belongs_to :user
  belongs_to :post
  has_many :replies, dependent: :destroy
  
  validates :content, presence: true, length:{maximum:140}
  validates :post_id, :user_id, presence: true

  default_scope -> { order(created_at: :desc) }
  
  #通过评论实例获取该评论客户的用户名
  def get_user
    @user = User.find_by(id: self.user_id)
  end
  
end
