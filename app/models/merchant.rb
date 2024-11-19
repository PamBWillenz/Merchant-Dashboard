class Merchant < ApplicationRecord
  has_many :customer_returns
  has_many :items, through: :customer_returns

  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: true


  def sum_of_returned_amounts
    customer_returns.joins(:items).sum('items.price')
  end
  # This method calculates the total return amounts 
  # by summing up the prices of all items associated with the customer returns

  def average_return_window
    recent_returns = customer_returns.where('registered_date > ?', 14.days.ago)
    # puts "Recent Returns: #{recent_returns.inspect}" # Debugging output
    return '-' if recent_returns.empty?

    total_days = recent_returns.sum do |customer_return|
      (customer_return.registered_date.to_date - customer_return.order_date.to_date).to_i # This calculates the difference in days instead of seconds  
    end

    average_window = total_days / recent_returns.count.to_f # This calculates the average return window in days
    # puts "Total Days: #{total_days}, Count: #{recent_returns.count}, Average Window: #{average_window}" # Debugging output

    average_window 
  end
  # This method calculates the average return window in days for returns created in the last 14 days. 
  # It calculates the difference in days between the registered_date and order_date for each return and then averages these values.
  # 
  # def as_json
  #   {
  #     id: id,
  #     name: name,
  #     total_return_amount: sum_of_returned_amounts,
  #     average_return_window: average_return_window,
  #     # customer_returns: customer_returns
  #   }    
  # #   # When we call as_json on ActiveRecord model object, 
  # #   # it returns json of attributes on model by calling as_json. 
  # #   # We can override as_json method and add extra attributes, rename keys, add values of methods on object to the json returned.
  # end
end

