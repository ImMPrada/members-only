class CreateMemberships < ActiveRecord::Migration[7.0]
  def change
    create_table :memberships do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :clubhouse, null: false, foreign_key: true
      t.string :role, null: false, default: Membership::MEMBER_ROLE

      t.timestamps
    end
  end
end
