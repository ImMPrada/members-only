class CreateClubhouses < ActiveRecord::Migration[7.0]
  def change
    create_table :clubhouses do |t|
      t.text :title, null: false
      t.text :description

      t.timestamps
    end
  end
end
