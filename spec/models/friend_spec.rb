require 'rails_helper'

RSpec.describe Friend, type: :model do
    context "validation specs" do
        subject(:friend) { FactoryGirl.build(:friend) }

        it "has a valid factory" do
            expect(friend).to be_valid
        end
        it "must have a name" do
            friend[:name] = nil
            expect(friend).to_not be_valid
        end
        it "must have a name with less than 50 char" do
            friend[:name] = "abcde"*12
            expect(friend).to_not be_valid
        end
        it "must have a category" do
            friend[:category] = nil
            expect(friend).to_not be_valid
        end
        it "belongs to a user" do
            friend[:user_id] = nil
            expect(friend).to_not be_valid
        end
    end
    context "logs" do
        subject (:user){ FactoryGirl.create(:user) }
        subject (:friend){ user.friends.first }

        it "has many logs" do
            expect(friend.logs.count).to be > 0
        end
        it "has dependent destroy for friend.logs" do
            expect{friend.destroy}.to change{friend.logs.count}.from(1).to(0)
        end
    end
end
