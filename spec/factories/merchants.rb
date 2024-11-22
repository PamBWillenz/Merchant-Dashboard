FactoryBot.define do
  factory :merchant do
    name { "Merchant #{Faker::Number.unique.number(digits: 2)}" }
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end