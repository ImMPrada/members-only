class CreateMembershipsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships_tables do |t|

      t.timestamps
    end
  end
end
