class CreateCustomerReturns < ActiveRecord::Migration[7.1]
  def change
    create_table :customer_returns do |t|
      t.datetime :order_date
      t.datetime :registered_date
      t.string :status
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
