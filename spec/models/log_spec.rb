require 'rails_helper'

describe Log, :type => :model do
    it "has a valid factory" do
        log = FactoryGirl.build(:log)
        expect(log).to be_valid
    end
    context "is invalid" do
        subject(:log){ FactoryGirl.build(:log) }

        it "without a :date" do
            log[:date] = nil
            expect(log).to_not be_valid
        end
        it "without a :friend_id" do
            log[:friend_id] = nil
            expect(log).to_not be_valid
        end
        it "if type_of is any besides Text, Audio, Video, In-Person, or nil" do
            log = FactoryGirl.build(:log, type_of: "something else")
            expect(log).to_not be_valid
        end
        it "if the :rating is a string" do
            log[:rating] = "not an integer"
            expect(log).to_not be_valid
        end
        it "if the :rating is a float" do
            log[:rating] = 1.435
            expect(log).to_not be_valid
        end
        it "if the rating is > 5" do
            log[:rating] = 6
            expect(log).to_not be_valid
        end
        it "if the :rating is < 1" do
            log[:rating] = 0
            expect(log).to_not be_valid
        end
    end
    context "is valid" do
        subject(:log){ FactoryGirl.build(:log) }
        it "without a :type_of" do
            log[:type_of] = nil
            expect(log).to be_valid
        end
        it "without a :rating" do
            log[:rating] = nil
            expect(log).to be_valid
        end
        it "if the :rating is an integer" do
            log[:rating] = 1
            expect(log).to be_valid
        end
        it "if the :rating is between 1-5" do
            (1..5).each do |i|
                log[:rating] = i
                expect(log).to be_valid
            end
        end
        it "without a :comment" do
            log[:comment] = nil
            expect(log).to be_valid
        end
    end
    context "def assemble_log will" do
        let(:user){ FactoryGirl.create(:user) }
        let(:friend){ FactoryGirl.create(:friend, user_id: user.id) }
        let(:data){ FactoryGirl.attributes_for(:log, friend_id: friend.id) }

        it "set :date to today if nil" do
            data[:date] = nil
            Log.assemble_log(data)
            expect(data[:date]).to eq(Date.today)
        end
        it "set :date to today if calendar field returns empty string" do
            data[:date] = ""
            Log.assemble_log(data)
            expect(data[:date]).to eq(Date.today)
        end
        it "call def set_type_of when type_of exists && != 0" do
            data[:type_of] = 2
            Log.assemble_log(data)
            expect(data[:type_of]).to eq("Audio")
        end
        it "not call set_type_of if type_of is nil" do
            data[:type_of] = nil
            Log.assemble_log(data)
            expect(data[:type_of]).to eq(nil)
        end
    end
    context "def create_log" do
        let(:user){ FactoryGirl.create(:user) }
        let(:friend){ FactoryGirl.create(:friend, user_id: user.id) }
        let(:data){ FactoryGirl.attributes_for(:log, friend_id: friend.id, date: nil) }
        
        it "calls assemble_log" do
            expect{ Log.create_log(friend, data) }.to change{ data[:date] }.to( Date.today )
        end
        it "creates log for given friend" do
            expect{ Log.create_log(friend, data) }.to change{ friend.logs.count }.by(1)
        end
    end
    context "def set_log_type" do
        it "sets type_of to the valid options of Text, Audio, Video, In-Person, or nil" do
            (1..5).each do |i|
                text = Log.set_log_type(i)
                log = FactoryGirl.build(:log, type_of: text)
                expect(log).to be_valid
            end
        end
    end
end