class AddRepliedIdToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :replied_id, :integer
  end
end
