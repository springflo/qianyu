class Post < ActiveRecord::Base
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    mount_uploader :picture, PictureUploader
    # validates :title, length:{maximum:40}, presence: true
    validates :content, length:{maximum:10000}, presence: true
    validates :user_id, presence: true
    # validate :picture_size #will be a bug if no picture
    
    private
        
        # # 验证上传的图像大小
        # def picture_size
        #     if !!picture? && picture_size > 5.megabytes
        #         errors.add(:picture, "图像应该小于 5MB")
        #     end
        # end
    
    
    
    
    
end
