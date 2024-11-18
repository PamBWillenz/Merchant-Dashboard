# spec/factories/customer_returns.rb
FactoryBot.define do
  factory :customer_return do
    order_date { Faker::Date.backward(days: 60) }
    registered_date { order_date + rand(1..14).days }
    status { %i[pending approved rejected refunded].sample }
    association :merchant
  end
end