require "rails_helper"

describe User, :type => :model do
    it "has a valid factory" do
        user = FactoryGirl.build(:user)
        expect(user).to be_valid
    end
    it "sends a confirmation email" do
        expect { FactoryGirl.create(:user) }.to change { ActionMailer::Base.deliveries.count }
    end
    context "is invalid" do
        subject(:user){ FactoryGirl.build(:confirmed_user) }

        it "without a :username" do
            user[:username] = nil
            expect(user).to_not be_valid
        end
        it "if :username > 50 characters" do
            user[:username] = "abcde"*12
            expect(user).to_not be_valid
        end
        it "without an :email" do
            user[:email] = nil
            expect(user).to_not be_valid
        end
        it "without a :password" do
            user = FactoryGirl.build(:user, password: nil) #intentionally left like this b/c "can't write unknown attribute `password`" error
            expect(user).to_not be_valid
        end
        it "without a unique :email" do
            user = FactoryGirl.create(:user, email: "test@test.com")
            expect(FactoryGirl.build(:user, email: "test@test.com")).to_not be_valid
        end
    end
    context "with friends" do
        let(:user){ FactoryGirl.create(:confirmed_user) }
        let(:friend){ FactoryGirl.create(:friend, user_id: user.id) }
        before(:each) do
            expect(friend).to be_valid
        end

        it "can have many friends" do
            expect(user.friends.count).to be > 0
        end
        it "has dependent destroy for user.friends" do
            expect{user.destroy}.to change{user.friends.count}.from(1).to(0)
        end
    end
end