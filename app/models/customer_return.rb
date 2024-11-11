class CustomerReturn < ApplicationRecord
  belongs_to :merchant
  has_many :items 

  STATUSES = %w[pending approved rejected refunded]

  validates :status, inclusion: { in: STATUSES }
  validate :return_window_within_limit

  private

  def return_window_within_limit
    if registered_date.present? && order_date.present? && (registered_date.to_date - order_date.to_date).to_i > 14
      errors.add(:registered_date, "must be within 14 days of the order date")
    end
  end
end
