FactoryBot.define do
  factory :merchant do
    name { "Merchant #{Faker::Number.unique.number(digits: 2)}" }
  end
end