class AddThumbsCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :thumbs_count, :integer, null: false, default: 0
    
    ids = Set.new
    Thumb.all.find_each { |r| ids << r.post_id }
    ids.each do |post_id|
      Post.reset_counters(post_id, :thumbs)
    end
  end
end
