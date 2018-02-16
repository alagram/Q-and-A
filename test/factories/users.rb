FactoryBot.define do
  factory :user do
    first_name "MyString"
    last_name "MyString"
    email { Faker::Internet.email }
    uid '12345'
    password { Devise.friendly_token }
  end
end
