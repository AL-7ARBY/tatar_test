# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :feedback do
    name {Faker::Name.name}
    phone {Faker::PhoneNumber.phone_number}
    email {Faker::Internet.email}
    content {Faker::Lorem.paragraph}
  end
end
