class CreateMembershipsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships_tables do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :clubhouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
