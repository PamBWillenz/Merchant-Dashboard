class MerchantSerializer < ActiveModel::Serializer
  attributes :id, :name, :total_return_amount, :average_return_window

  def total_return_amount
    object.sum_of_returned_amounts
  end

  # def average_return_window
  #   object.average_return_window
  # end
end
