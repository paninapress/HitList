require "rails_helper"

describe User, :type => :model do
    it "must have a username" do
        user = FactoryGirl.build(:user, username: nil)
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
end