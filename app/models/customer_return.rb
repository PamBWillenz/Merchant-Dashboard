class CustomerReturn < ApplicationRecord
  belongs_to :merchant
  has_many :items 

  enum status: { pending: 0, approved: 1, rejected: 2, refunded: 3 }

  # STATUSES = %w[pending approved rejected refunded]

  # Enum is a feature in Rails that allows you to declare an attribute with a value that maps to an integer in the database.
  # enum :status, STATUSES.zip(STATUSES).to_h

  # validates :status, inclusion: { in: STATUSES }
  validate :return_window_within_limit

  private

  def return_window_within_limit
    if registered_date.present? && order_date.present? && (registered_date.to_date - order_date.to_date).to_i > 14
      errors.add(:registered_date, "must be within 14 days of the order date")
    end
  end
end
