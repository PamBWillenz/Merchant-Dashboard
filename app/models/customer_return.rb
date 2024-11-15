class CustomerReturn < ApplicationRecord
  belongs_to :merchant
  has_many :items 

  STATUSES = %w[pending approved rejected refunded]

  # Enum is a feature in Rails that allows you to declare an attribute with a value that maps to an integer in the database.
  # enum :status, STATUSES.zip(STATUSES).to_h

  # how enum works in Rails. pros / cons of using enum.
  # enum integer vs string value in database. pros / cons.
  # look at some examples and read and test them.
  # customer_return.update!(status: 'Pending');
  # CustomerReturn.pending
  # CustomerReturn.where(status: 'pending')
  

  validates :status, inclusion: { in: STATUSES }
  validate :return_window_within_limit

  private

  def return_window_within_limit
    if registered_date.present? && order_date.present? && (registered_date.to_date - order_date.to_date).to_i > 14
      errors.add(:registered_date, "must be within 14 days of the order date")
    end
  end
end
