module ApplicationHelper
    
    def full_title(page_title = '')
        base_title = "千语"
        if page_title.empty?
            base_title
        else
            page_title + "|" + base_title
        end
    end
    
    
    # 获取创建时间
    # 当小于60秒的时候返回时间为xx秒前； 
    # 当小于60分钟大于等于60秒时返回xx分钟前； 
    # 当小于24小时大于等于60分钟时返回xx小时前；
    # 当大于等于1天的时候，显示xxxx-xx-xx xx-xx时间；
    def get_created_at
      created_at = self.created_at
      now = Time.now
      time_distance = (now - created_at).to_i
      if time_distance == 0
        "刚刚"
      elsif time_distance < 60
        "#{time_distance}秒前"
      elsif time_distance/60 < 60
        "#{time_distance/60}分钟前"
      elsif time_distance/(60*60) < 12
        "#{time_distance/(60*60)}小时前"
      else
        created_at.strftime("%Y-%m-%d %H:%M")
      end
    end
    
    
end
