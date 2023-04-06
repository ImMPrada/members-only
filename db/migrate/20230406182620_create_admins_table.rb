class CreateAdminsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :admins_tables do |t|

      t.timestamps
    end
  end
end
