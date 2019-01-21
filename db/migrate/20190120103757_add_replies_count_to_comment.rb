class AddRepliesCountToComment < ActiveRecord::Migration
  def change
    add_column :comments, :replies_count, :integer, default: 0
    
    ids = Set.new
    Reply.all.find_each { |r| ids << r.comment_id }
    ids.each do |comment_id|
      Comment.reset_counters(comment_id, :replies)
    end
  end
end
