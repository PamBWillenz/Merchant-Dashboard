class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :name
      t.decimal :price
      t.references :customer_return, null: false, foreign_key: true

      t.timestamps
    end
  end
end
