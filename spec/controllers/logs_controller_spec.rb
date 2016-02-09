require 'rails_helper'
require 'support/devise'

RSpec.describe LogsController, type: :controller do
    context "POST #create" do
        login_user
        it "creates new log" do
            expect{ post :create, log: FactoryGirl.attributes_for(:log) }.to change(Log,:count).by(1)
        end
    end
end
