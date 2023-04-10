FactoryBot.define do
  factory :user do
    username { Faker::Name.first_name.gsub(/\W/, '') }
    email { Faker::Internet.email }
  end
end
