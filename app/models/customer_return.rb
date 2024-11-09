class CustomerReturn < ApplicationRecord
  belongs_to :merchant
  has_many :items 

  STATUSES = %w[pending approved rejected]

  validates :status, inclusion: { in: STATUSES }
end
