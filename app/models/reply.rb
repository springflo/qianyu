class Reply < ActiveRecord::Base
  belongs_to :comment
  belongs_to :user
  include ApplicationHelper
  
  def get_replied_user
    @user = User.find(replied_id)
  end
  
end
