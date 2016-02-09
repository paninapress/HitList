require 'rails_helper'

RSpec.describe Friend, type: :model do
    it "has a valid factory" do
        friend = FactoryGirl.build(:friend)
        expect(friend).to be_valid
    end
    it "must have a name" do
        friend = FactoryGirl.build(:friend, name: nil)
        expect(friend).to_not be_valid
    end
    it "must have a name with less than 50 char" do
        friend = FactoryGirl.build(:friend,name:"abcde"*12)
        expect(friend).to_not be_valid
    end
    it "must have a category" do
        friend = FactoryGirl.build(:friend, category: nil)
        expect(friend).to_not be_valid
    end
    it "belongs to a user" do
        friend = FactoryGirl.build(:friend, user_id: nil)
        expect(friend).to_not be_valid
    end
    it "has many logs" do
        user = FactoryGirl.create(:user)
        friend = user.friends.first
        expect(friend.logs.count).to be > 0
    end
end
