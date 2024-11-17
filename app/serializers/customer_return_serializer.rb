class CustomerReturnSerializer < ActiveModel::Serializer
  attributes :id, :order_date, :registered_date, :status, :merchant_id
  has_many :items
end
