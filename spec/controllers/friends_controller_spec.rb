require 'rails_helper'
require 'support/devise'

RSpec.describe FriendsController, type: :controller do
	context "GET #index" do
        login_user
        it "should have a current_user" do
            expect(subject.current_user).to_not be_nil
        end

        it "responds successfully with an HTTP 200 status code" do
            get :index
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "GET #new" do
        login_user
        it "responds successfully with an HTTP 200 status code" do
            get :new
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
    end
    context "POST #create" do
        login_user
        it "creates new friend" do
            expect{ post :create, friend: FactoryGirl.attributes_for(:friend) }.to change(Friend,:count).by(1)
        end
        it "sets user_id to the current_user's id" do
            current_user = subject.current_user
            post :create, friend: FactoryGirl.attributes_for(:friend)
            expect( Friend.last.user_id ).to be( current_user.id )
        end
        it "redirects to the new contact" do
            post :create, friend: FactoryGirl.attributes_for(:friend)
            expect(response).to redirect_to friend_path(Friend.last.id)
        end
    end
    context "GET #show" do
        login_user
        it "responds successfully with an HTTP 200 status code" do
            get :show, id: FactoryGirl.attributes_for(:friend)
            expect(response).to be_success
            expect(response).to have_http_status(200)
        end
        # it "finds friend with given id" do
        #     get :show, id: FactoryGirl.attributes_for(:friend)
        #     expect
        # end
    end
end
