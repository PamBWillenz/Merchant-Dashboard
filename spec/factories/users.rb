FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password_digest { 'password' }
    password_confirmation { 'password' }
  end
end
