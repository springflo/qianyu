class Post < ActiveRecord::Base
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    # validates :title, length:{maximum:40}, presence: true
    validates :content, length:{maximum:10000}, presence: true
    validates :user_id, presence: true
    
    
    
    
    
end
