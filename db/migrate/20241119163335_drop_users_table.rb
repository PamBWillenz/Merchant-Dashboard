class DropUsersTable < ActiveRecord::Migration[7.1]
  def up 
    drop_table :users
  end

  def down
    create_table :users do |t|
      t.string :email
      t.string :password_digest

      t.timestamps
    end
  end
end
