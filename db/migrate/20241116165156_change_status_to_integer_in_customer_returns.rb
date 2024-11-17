class ChangeStatusToIntegerInCustomerReturns < ActiveRecord::Migration[7.1]
  def up
    # Add a temporary column to store the integer values
    add_column :customer_returns, :status_temp, :integer, default: 0

    # Map existing string values to integers
    CustomerReturn.reset_column_information
    CustomerReturn.find_each do |customer_return|
      case customer_return.status
      when 'pending'
        customer_return.update_column(:status_temp, 0)
      when 'approved'
        customer_return.update_column(:status_temp, 1)
      when 'rejected'
        customer_return.update_column(:status_temp, 2)
      when 'refunded'
        customer_return.update_column(:status_temp, 3)
      end
    end

    # Remove the original status column
    remove_column :customer_returns, :status

    # Rename the temporary column to status
    rename_column :customer_returns, :status_temp, :status

    # Set default value for the new status column
    change_column_default :customer_returns, :status, 0
  end

  def down
    # Add the original status column back
    add_column :customer_returns, :status_temp, :string

    # Map existing integer values back to strings
    CustomerReturn.reset_column_information
    CustomerReturn.find_each do |customer_return|
      case customer_return.status
      when 0
        customer_return.update_column(:status_temp, 'pending')
      when 1
        customer_return.update_column(:status_temp, 'approved')
      when 2
        customer_return.update_column(:status_temp, 'rejected')
      when 3
        customer_return.update_column(:status_temp, 'refunded')
      end
    end

    # Remove the integer status column
    remove_column :customer_returns, :status

    # Rename the temporary column back to status
    rename_column :customer_returns, :status_temp, :status
  end
end