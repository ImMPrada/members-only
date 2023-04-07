class CreateUsersTable < ActiveRecord::Migration[7.0]
  def change
    create_table :users_tables do |t|
      t.string :username, null: falsen, unique: true
      t.string :email, null: false, unique: true

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
  end
end
