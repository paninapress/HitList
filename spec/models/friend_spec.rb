require 'rails_helper'

RSpec.describe Friend, type: :model do
    it "has a valid factory" do
        friend = FactoryGirl.build(:friend)
        expect(friend).to be_valid
    end
    context "is invalid" do
        subject(:friend) { FactoryGirl.build(:friend) }

        it "without a :name" do
            friend[:name] = nil
            expect(friend).to_not be_valid
        end
        it "if :name > 50 characters" do
            friend[:name] = "abcde"*12
            expect(friend).to_not be_valid
        end
        it "without a :category" do
            friend[:category] = nil
            expect(friend).to_not be_valid
        end
        it "without a :user_id" do
            friend[:user_id] = nil
            expect(friend).to_not be_valid
        end
    end

    context "with logs" do
        let(:user){ FactoryGirl.create(:user) }
        let(:friend){ FactoryGirl.create(:friend, user_id: user.id) }
        let(:log){ FactoryGirl.create(:log, friend_id: friend.id) }
        before(:each) do
            expect(log).to be_valid
        end

        it "can have many logs" do
            expect(friend.logs.count).to be > 0
        end
        it "has dependent destroy for friend.logs" do
            expect{friend.destroy}.to change{friend.logs.count}.from(1).to(0)
        end
    end
end
