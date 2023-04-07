class CreatePostsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :posts_tables do |t|
      t.text :content, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :clubhouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
