class CreateClubhousesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :clubhouses_tables do |t|

      t.timestamps
    end
  end
end
