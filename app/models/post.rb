class Post < ActiveRecord::Base
  
    include ApplicationHelper
    
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :thumbs, dependent: :destroy  
    
    default_scope -> { order(created_at: :desc) }
    
    mount_uploader :picture, PictureUploader
    
    # validates :title, length:{maximum:40}, presence: true
    validates :content, length:{maximum:400}, presence: true
    validates :user_id, presence: true
    # validate :picture_size #will be a bug if no picture
    
    #获取此用户是否给该帖子点过赞，默认为未点过
    def thumbed?(user_id)
      thumb = Thumb.find_by(post_id: id, user_id: user_id)
      if thumb && !!thumb.is_thumb
        return true
      else
        return false
      end
    end
   
    def count_thumbs
      thumbs_count = self.thumbs.count
      if self.thumbs_count != thumbs_count
        self.update_attribute(:thumbs_count, thumbs_count)
      end
      return thumbs_count
    end 
    
    
    private
        
        # # 验证上传的图像大小
        # def picture_size
        #     if !!picture? && picture_size > 5.megabytes
        #         errors.add(:picture, "图像应该小于 5MB")
        #     end
        # end
    
end
