class Reply < ActiveRecord::Base
  
  include ApplicationHelper
  
  belongs_to :comment
  belongs_to :user
  
  validates :content, presence: true, length:{maximum:140}
  validates :comment_id, :user_id, :replied_id, presence: true

  def get_replied_user
    @user = User.find(replied_id)
  end
  
end
