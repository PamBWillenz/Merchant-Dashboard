class AddPasswordDigestToMerchants < ActiveRecord::Migration[7.1]
  def change
    add_column :merchants, :password_digest, :string
  end
end
