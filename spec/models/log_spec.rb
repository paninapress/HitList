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
    it "is valid without a rating scale" do
        log = FactoryGirl.build(:log, rating: nil)
        expect(log).to be_valid
    end
    it "is valid without a comment" do
        log = FactoryGirl.build(:log, comment: nil)
        expect(log).to be_valid
    end
    it "only allows Text, Audio, Video, In-Person responses for type"
    it "only allows the rating scale to be a number from 1-5"
end