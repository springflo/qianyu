class AddCommentsCountToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :comments_count, :integer, default: 0
    
    ids = Set.new
    Comment.all.find_each { |r| ids << r.post_id }
    ids.each do |post_id|
      Post.reset_counters(post_id, :comments)
    end
  end
end
