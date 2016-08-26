FactoryGirl.define do  
  factory :user do
    username { Faker::Internet.name }
    email { Faker::Internet.email }
    password "password"
    password_confirmation "password"
    factory :confirmed_user do
      confirmed_at Date.today
    end
    # after(:create) do | user |
    #   friend = FactoryGirl.create(:friend, user_id: user.id)
    #   friend.logs << FactoryGirl.create(:log, friend_id: friend.id)
    # end
  end
  factory :friend do
    name { Faker::Internet.name }
    category 1
    user_id 1
  end
  factory :log do
    date "2016-01-01"
    type_of nil
    rating 1
    comment "MyText"
    friend_id 1
  end
end