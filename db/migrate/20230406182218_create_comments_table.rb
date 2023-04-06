class CreateCommentsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :comments_tables do |t|

      t.timestamps
    end
  end
end
