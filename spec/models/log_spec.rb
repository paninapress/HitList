require 'rails_helper'

describe Log, :type => :model do
    it "has a valid factory" do
        log = FactoryGirl.build(:log)
        expect(log).to be_valid
    end
    it "must have a date" do
        log = FactoryGirl.build(:log, date: nil)
        expect(log).to_not be_valid
    end
    it "belongs to a Friend" do
        log = FactoryGirl.build(:log, friend_id: nil)
        expect(log).to_not be_valid
    end
    it "is valid without a type_of" do
        log = FactoryGirl.build(:log, type_of: nil)
        expect(log).to be_valid
    end
    it "is valid without a rating" do
        log = FactoryGirl.build(:log, rating: nil)
        expect(log).to be_valid
    end
    it "has only allows integers for the rating" do
        log = FactoryGirl.build(:log, rating: "something else")
        expect(log).to_not be_valid
        log2 = FactoryGirl.build(:log, rating: 1.435)
        expect(log2).to_not be_valid
    end
    it "only allows the rating to be a number from 1-5" do
        log_fail = FactoryGirl.build(:log, rating: 6)
        expect(log_fail).to_not be_valid
        log_pass = FactoryGirl.build(:log, rating: 5)
        expect(log_pass).to be_valid
    end
    it "is valid without a comment" do
        log = FactoryGirl.build(:log, comment: nil)
        expect(log).to be_valid
    end
    context "create_log" do
        it "sets date to today's date if none given" do
            user = FactoryGirl.create(:user)
            friend = user.friends.first
            data = FactoryGirl.attributes_for(:log, friend_id: friend.id, date: nil)
            Log.create_log(friend, data)
            expect(data[:date]).to eq(Date.today)
        end
        it "calls set_type_of when type_of exists" do
            user = FactoryGirl.create(:user)
            friend = user.friends.first
            data = FactoryGirl.attributes_for(:log, friend_id: friend.id, type_of: 2)
            Log.create_log(friend, data)
            expect(data[:type_of]).to eq("Audio")
        end
        it "doesn't call set_type_of if type_of is nil" do
            user = FactoryGirl.create(:user)
            friend = user.friends.first
            data = FactoryGirl.attributes_for(:log, friend_id: friend.id, type_of: nil)
            Log.create_log(friend, data)
            expect(data[:type_of]).to eq(nil)
        end
        it "creates log for given friend" do
            user = FactoryGirl.create(:user)
            friend = user.friends.first
            data = FactoryGirl.attributes_for(:log, friend_id: friend.id)
            Log.create_log(friend, data)
            expect{ Log.create_log(friend, data) }.to change{ friend.logs.count }.by(1)
        end
    end
    it "only allows Text, Audio, Video, In-Person responses for type" do
        (1..4).each do |i|
            text = Log.set_log_type(i)
            log = FactoryGirl.build(:log, type_of: text)
            expect(log).to be_valid
        end
        log = FactoryGirl.build(:log, type_of: "something else")
        expect(log).to_not be_valid
    end
end