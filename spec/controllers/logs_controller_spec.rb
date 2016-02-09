require 'rails_helper'
require 'support/devise'

RSpec.describe LogsController, type: :controller do
	context "GET #new" do
        login_user
        it "responds successfully with an HTTP 200 status code" do
            get :new, {friend_id: Friend.last}
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    # context "POST #create" do
    #     login_user
    #     it "creates new log" do
    #         expect{ post :create, log: FactoryGirl.attributes_for(:log) }.to change(Log,:count).by(1)
    #     end
    # end
end