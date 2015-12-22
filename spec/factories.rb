FactoryGirl.define do  
  factory :user do
  	username { Faker::Internet.name }
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    confirmed_at Date.today
  end
  factory :friend do
    name { Faker::Internet.name }
    category 1
  end
end