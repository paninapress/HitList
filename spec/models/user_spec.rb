require "rails_helper"

describe User, :type => :model do
    it "has a valid factory" do
        user = FactoryGirl.build(:user)
        expect(user).to be_valid
    end
    it "must have a username" do
        user = FactoryGirl.build(:user, username: nil)
        expect(user).to_not be_valid
    end
    it "must have a username with less than 50 char" do
        user=FactoryGirl.build(:user,username:"abcde"*12)
        expect(user).to_not be_valid
    end
    it "must have an email" do
    	user = FactoryGirl.build(:user, email: nil)
    	expect(user).to_not be_valid
    end
    it "must have a password" do
    	user = FactoryGirl.build(:user, password: nil)
    	expect(user).to_not be_valid
    end
    it "must have a unique email" do
    	user1 = FactoryGirl.create(:user, email: "test@test.com")
    	expect(FactoryGirl.build(:user, email: "test@test.com")).to_not be_valid
    end
    it "has many friends" do
        user = FactoryGirl.create(:user)
        expect(user.friends.count).to be > 0
    end
end