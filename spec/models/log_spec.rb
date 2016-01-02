require 'rails_helper'

describe Log, :type => :model do
	it "belongs to a Friend"
	it "must have a date"
	it "is valid without a type"
	it "only allows Text, Audio, Video, In-Person responses for type"
	it "is valid without a rating scale"
	it "only allows the rating scale to be a number from 1-5"
	it "is valid without a comment"
end