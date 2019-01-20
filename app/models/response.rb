class Response < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validates :body, presence: true
  validates :post_id, :user_id, presence: true
  
    
  
  
end
