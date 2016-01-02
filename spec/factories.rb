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
    user_id nil
  end
  factory :log do
    date "2016-01-01"
    type ""
    rating 1
    comment "MyText"
    friend nil
  end
end