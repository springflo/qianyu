class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.references :comment, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.text :content
      t.integer :status, default: 0

      t.timestamps null: false
    end
  end
end
