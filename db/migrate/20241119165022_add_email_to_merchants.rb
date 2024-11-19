class AddEmailToMerchants < ActiveRecord::Migration[7.1]
  def change
    add_column :merchants, :email, :string
    add_index :merchants, :email, unique: true
  end
end
