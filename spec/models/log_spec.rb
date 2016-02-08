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
    it "is valid without a type" do
        log = FactoryGirl.build(:log, type: nil)
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
end