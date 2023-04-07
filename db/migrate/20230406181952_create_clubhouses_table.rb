class CreateClubhousesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :clubhouses_tables do |t|
      t.text :title, null: false
      t.text :description
      t.belongs_to :admin, null: false, foreign_key: true

      t.timestamps
    end

    add_index :clubhouse, %i[admin_id title], unique: true
  end
end
