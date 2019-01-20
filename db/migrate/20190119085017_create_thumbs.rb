class CreateThumbs < ActiveRecord::Migration
  def change
    create_table :thumbs do |t|
      t.boolean :is_thumb, null: false, default: false
      t.references :user, index: true, foreign_key: true
      t.references :post, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
