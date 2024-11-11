class Merchant < ApplicationRecord
  has_many :customer_returns
  has_many :items, through: :customer_returns


  def sum_of_returned_amounts
    customer_returns.joins(:items).sum('items.price')
  end
  # This method calculates the total return amounts 
  # by summing up the prices of all items associated with the customer returns

  def average_return_window
    recent_returns = customer_returns.where('registered_date > ?', 14.days.ago)
    return '-' if recent_returns.empty?

    total_days = recent_returns.sum do |customer_return|
      (customer_return.registered_date - customer_return.order_date).to_i
    end

    total_days / recent_returns.count
  end
  # This method calculates the average return window in days for returns created in the last 14 days. 
  # It calculates the difference in days between the registered_date and order_date for each return and then averages these values.
end

