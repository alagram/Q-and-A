FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    uid '12345'
    password { Devise.friendly_token }
  end
end
